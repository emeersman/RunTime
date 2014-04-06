//
//  RunTimerViewController.h
//  RunTime
//
//  Created by HMC on 3/25/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Timer.h"

@interface RunTimerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *beginTimer;
@property (strong, nonatomic) NSTimer *currTimer;

@property (nonatomic, strong) IBOutlet Timer *selectTimer;
@property (weak, nonatomic) IBOutlet UITableView *miniTableView;

@property (weak, nonatomic) IBOutlet UIButton *resetTimer;

@property (weak, nonatomic) IBOutlet UITextField *timerHr;
@property (weak, nonatomic) IBOutlet UITextField *timerMin;
@property (weak, nonatomic) IBOutlet UITextField *timerSec;
@property (weak, nonatomic) IBOutlet UITextField *instrId;
@property (weak, nonatomic) IBOutlet UILabel *timerName;
@property (weak, nonatomic) IBOutlet UITextField *timerReps;
@property (weak, nonatomic) IBOutlet UITextField *instrReps;

@end
