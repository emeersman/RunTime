//
//  RunTimerViewController.h
//  RunTime
//
//  Created by HMC on 3/25/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Timer.h"

@interface RunTimerViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *beginTimer;
@property (strong, nonatomic) NSTimer *currTimer;

// The timer we selected from SavedTimers
@property (nonatomic, strong) IBOutlet Timer *selectTimer;

// Table of instructions!
@property (weak, nonatomic) IBOutlet UITableView *miniTableView;

// Reset button
@property (weak, nonatomic) IBOutlet UIButton *resetTimer;
@property (nonatomic) void *finishInstr;

// All of the text fields
@property (weak, nonatomic) IBOutlet UITextField *timerHr;
@property (weak, nonatomic) IBOutlet UITextField *timerMin;
@property (weak, nonatomic) IBOutlet UITextField *timerSec;
@property (weak, nonatomic) IBOutlet UITextField *instrId;
@property (weak, nonatomic) IBOutlet UILabel *timerName;
@property (weak, nonatomic) IBOutlet UITextField *timerReps;
@property (weak, nonatomic) IBOutlet UITextField *instrReps;


extern NSInteger secValueC;
extern NSInteger minValueC;
extern NSInteger hrValueC;
extern BOOL startedC;
@end
