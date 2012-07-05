//
//  ASQViewController.m
//  ASequenceQueue
//
//  Created by chao wang on 12-6-11.
//  Copyright (c) 2012年 bupt. All rights reserved.
//

#import "ASQViewController.h"

@interface ASQViewController ()

@end

@implementation ASQViewController

@synthesize label = _label;
@synthesize asqueue = _asqueue;

- (IBAction)btClicked:(id)sender{
    if (_asqueue.running) {
        return;
    }
    [_asqueue addMainQueueBlock:^(id inparam){
        self.label.text = @"Step 1...";
        [_asqueue done:nil];
    }];
    [_asqueue addAsyncBlock:^(id inparam){
        sleep(5);
        [_asqueue done:@"Result1"];
    }];
    [_asqueue addMainQueueBlock:^(id inparam){
        self.label.text = [NSString stringWithFormat:@"Result:%@ Step 2...",inparam];
        [_asqueue done:nil];
    }];
    [_asqueue addAsyncBlock:^(id inparam){
        sleep(5);
        [_asqueue done:nil];
    }];
    [_asqueue addMainQueueBlock:^(id inparam){
        self.label.text = @"End";
        [_asqueue done:nil];
    }];
    [_asqueue start:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.asqueue = [[[ASQueue alloc] init] autorelease];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc{
    [_asqueue release];
    [_label release];
    [super dealloc];
}

@end
