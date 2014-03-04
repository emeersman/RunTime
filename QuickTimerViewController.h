//
//  QuickTimerViewController.h
//  RunTime
//
//  Created by HMC on 2/24/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickTimerViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startTimer;
@property (weak, nonatomic) IBOutlet UIButton *resetTimer;
@property (weak, nonatomic) IBOutlet UITextField *timerHr;
@property (weak, nonatomic) IBOutlet UITextField *timerMin;
@property (weak, nonatomic) IBOutlet UITextField *timerSec;
@property (strong, nonatomic) NSTimer *quickTimer;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

//- (void)resetMin;
//- (void)resetSec;

extern NSInteger secValue;
extern NSInteger minValue;
extern NSInteger hrValue;
extern BOOL started;
@end
