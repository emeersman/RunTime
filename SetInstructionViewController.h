//
//  SetInstructionViewController.h
//  RunTime
//
//  Created by HMC on 3/25/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetInstructionViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *instructionName;
@property (weak, nonatomic) IBOutlet UITextField *instructionRepeat;
@property (weak, nonatomic) IBOutlet UITextField *iHour;
@property (weak, nonatomic) IBOutlet UITextField *iMinute;
@property (weak, nonatomic) IBOutlet UITextField *iSecond;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveIntervalButtonBar;


@end
