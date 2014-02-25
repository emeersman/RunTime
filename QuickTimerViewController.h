//
//  QuickTimerViewController.h
//  RunTime
//
//  Created by HMC on 2/24/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickTimerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *startTimer;
@property (weak, nonatomic) IBOutlet UIButton *resetTimer;

@property (weak, nonatomic) IBOutlet UITextField *timerSec;
@property (strong, nonatomic) NSTimer *quickTimer;

extern NSInteger secValue;
extern BOOL started;
@end
