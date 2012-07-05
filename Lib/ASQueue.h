//
//  ASQueue.h
//  ASequenceQueue
//
//  Created by chao wang on 12-6-11.
//  Copyright (c) 2012年 bupt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ASQueueBlock)(id inparam);

@interface ASQueueItem : NSObject{
    ASQueueBlock _block;
    dispatch_queue_t _t;
}

@property (nonatomic,copy) ASQueueBlock block;
@property (nonatomic,assign) dispatch_queue_t t;

@end

@interface ASQueue : NSObject{
    NSMutableArray* _queue;
    BOOL _running;
}

@property (nonatomic,readonly) BOOL running;

- (void)addItem:(ASQueueItem*)item;
- (void)addBlock:(ASQueueBlock)block inQueue:(dispatch_queue_t)queue;
- (void)addMainQueueBlock:(ASQueueBlock)block;
- (void)addAsyncBlock:(ASQueueBlock)block;
- (void)start:(id)inparam;
- (void)done:(id)param;
- (void)doneAll;

@end
