//
//  ASQViewController.h
//  ASequenceQueue
//
//  Created by chao wang on 12-6-11.
//  Copyright (c) 2012年 bupt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASQueue.h"

@interface ASQViewController : UIViewController{
    UILabel* _label;
    ASQueue* _asqueue;
}

@property (nonatomic,retain) IBOutlet UILabel* label;
@property (nonatomic,retain) ASQueue* asqueue;

- (IBAction)btClicked:(id)sender;

@end
