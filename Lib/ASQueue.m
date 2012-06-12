//
//  ASQueue.m
//  ASequenceQueue
//
//  Created by chao wang on 12-6-11.
//  Copyright (c) 2012年 bupt. All rights reserved.
//

#import "ASQueue.h"

@implementation ASQueueItem

@synthesize t = _t;
@synthesize block = _block;

- (void)setT:(dispatch_queue_t)t{
    if (t != _t) {
        if (_t) {
            dispatch_release(_t);
        }
        dispatch_retain(t);
        _t = t;
    }
}

@end

@interface ASQueue (Private)

- (void)_scheduleNext:(id)inparam;

@end

@implementation ASQueue

@synthesize running = _running;

- (id)init{
    if ([super init]) {
        _queue = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addItem:(ASQueueItem*)item{
    if (!item) {
        return;
    }
    [_queue addObject:item];
}

- (void)addBlock:(ASQueueBlock)block inQueue:(dispatch_queue_t)queue{
    ASQueueItem* item = [[[ASQueueItem alloc] init] autorelease];
    item.block = block;
    item.t  = queue;
    [self addItem:item];
}

- (void)addMainQueueBlock:(ASQueueBlock)block{
    [self addBlock:block inQueue:dispatch_get_main_queue()];
}

- (void)addAsyncBlock:(ASQueueBlock)block{
    [self addBlock:block inQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

- (void)start:(id)inparam{
    if (_running) {
        return;
    }
    _running = YES;
    [self _scheduleNext:inparam];
}

- (void)_scheduleNext:(id)inparam{
    if ([_queue count] <= 0) {
        _running = NO;
        return;
    }
    ASQueueItem* item = [_queue objectAtIndex:0];
    dispatch_async(item.t, ^{
        id ret = item.block(inparam);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_queue removeObjectAtIndex:0];
            [self _scheduleNext:ret];
        });
    });
}


- (void)dealloc{
    [_queue release];
    [super dealloc];
}

@end
