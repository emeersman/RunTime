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

@property (nonatomic, strong) IBOutlet Timer *selectTimer;
@property (weak, nonatomic) IBOutlet UITextField *instrId;
@property (weak, nonatomic) IBOutlet UILabel *timerName;
@property (weak, nonatomic) IBOutlet UITextField *timerReps;

@end
