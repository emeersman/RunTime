//
//  SetTimerViewController.h
//  RunTime
//
//  Created by HMC on 3/3/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTimerViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *timerName;
@property (weak, nonatomic) IBOutlet UITextField *timerRepeat;

//linked to the Save Timer button in the navigation bar!
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveTimerButtonBar;

//the table in intervals!
@property (weak, nonatomic) IBOutlet UITableView *intervalTable;


@end
