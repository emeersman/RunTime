//
//  EditSingleTimerViewController.h
//  RunTime
//
//  Created by Sarah Scheffler on 4/22/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Timer.h"

@interface EditSingleTimerViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate>

//the timer we selected from EdiTimersViewController
@property (nonatomic, strong) IBOutlet Timer *selectTimer;

//Table of instructions
@property (weak, nonatomic) IBOutlet UITableView *instructionTable;

//all of the text fields

@property (weak, nonatomic) IBOutlet UITextField *timerNameField;

@property (weak, nonatomic) IBOutlet UITextField *repeatNumber;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButton;

@end
