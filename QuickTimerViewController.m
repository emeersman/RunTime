//
//  QuickTimerViewController.m
//  RunTime
//
//  Created by HMC on 2/24/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "QuickTimerViewController.h"
#import "AudioToolbox/AudioToolbox.h"

@interface QuickTimerViewController ()

@end

@implementation QuickTimerViewController

int secValue = 0;
int secCountDown = 0;
int minValue = 0;
int minCountDown = 0;
int hrValue = 0;
int hrCountDown = 0;
BOOL started = NO;

int alarmOn = 0;

SystemSoundID alarmSound;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.timerMin.delegate = self;
    self.timerSec.delegate = self;
    self.timerHr.delegate = self;
    
    self.navigationItem.hidesBackButton = YES;
    
    NSURL *soundURL = [[NSBundle mainBundle]                                       URLForResource:@"alarmSound" withExtension:@"caf"];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(soundURL), &alarmSound);
    
    //_titleImage.image = [UIImage imageNamed:@"heman.jpg"];
}

- (IBAction)secValueChanged:(id)sender {
    secValue = [_timerSec.text intValue];
    secCountDown = [_timerSec.text intValue];
}

- (IBAction)minValueChanged:(id)sender {
    minValue = [_timerMin.text intValue];
    minCountDown = [_timerMin.text intValue];
}

- (IBAction)hrValueChanged:(id)sender {
    hrValue = [_timerHr.text intValue];
    hrCountDown = [_timerHr.text intValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *) timerField {
    [self.view endEditing:YES];
    [timerField resignFirstResponder];
    return YES;
}

- (IBAction)beginTimer:(id)sender {
    if (!started) {
        self.quickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:self
                                                         selector:@selector(updateTimer:)
                                                         userInfo:nil
                                                          repeats:YES];
        
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: self.quickTimer forMode: NSDefaultRunLoopMode];
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        started = YES;
    }
    else {
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        started = NO;
        if(_quickTimer){
            [_quickTimer invalidate];
            _quickTimer = nil;
        }
    }
    
}
/*
-(void)resetSec {
    if(secCountDown > 0)
    {
        self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDown];
    }
}

-(void)resetMin {
    if(minCountDown > 0) {
        if(secCountDown == 0) {
            self.timerMin.text = [NSString stringWithFormat:@"%d", --minCountDown];
            self.timerSec.text = [NSString stringWithFormat:@"%d", 59];
            secCountDown = 59;
        }
        else
        {
            self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDown];
        }
    }
    else{
        self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDown];
    }
}*/

-(void)updateTimer:(NSTimer *)timer {
    if(hrCountDown > 0)
    {
        if(minCountDown == 0 && secCountDown == 0)
        {
            self.timerHr.text = [NSString stringWithFormat:@"%d", --hrCountDown];
            self.timerMin.text = [NSString stringWithFormat:@"%d", 59];
            self.timerSec.text = [NSString stringWithFormat:@"%d", 59];
            minCountDown = 59;
            secCountDown = 59;
        }
        else {
            if(minCountDown > 0) {
                if(secCountDown == 0) {
                    self.timerMin.text = [NSString stringWithFormat:@"%d", --minCountDown];
                    self.timerSec.text = [NSString stringWithFormat:@"%d", 59];
                    secCountDown = 59;
                }
                else
                {
                    self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDown];
                }
            }
            else{
                self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDown];
            }
        }
    }
    else {
        if(minCountDown > 0) {
            if(secCountDown == 0) {
                self.timerMin.text = [NSString stringWithFormat:@"%d", --minCountDown];
                self.timerSec.text = [NSString stringWithFormat:@"%d", 59];
                secCountDown = 59;
            }
            else
            {
                self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDown];
            }
        }
        else{
            if(secCountDown > 0)
            {
                self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDown];
                _titleImage.image = [UIImage imageNamed:@"heman.jpg"];
                
                if (alarmOn != 0)
                {
                    alarmOn = 0;
                }
            }
            else //zero things
            {
                _titleImage.image = [UIImage imageNamed:@"skeletor.jpg"];
                
                if (alarmOn == 0) //readd this statement if we only want the alarm to sound once
                {
                    //SystemSoundID alarmSound;
                
                    //separate loading the sounds into it's own file and just keep it loaded until
                    //exit the app?
                
                    //NSURL *soundURL = [[NSBundle mainBundle]                                       URLForResource:@"alarmSound" withExtension:@"caf"];
                    //AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(soundURL), &alarmSound);
                    AudioServicesPlayAlertSound(alarmSound);
                    
                    alarmOn++;
                }
                
                //clean-up
                //AudioServicesRemoveSystemSoundCompletion(_alarmSound);
                //AudioServicesDisposeSystemSoundID(_alarmSound);
                
            }
        }
    }
    if(hrCountDown < 10)
        _timerHr.text = [NSString stringWithFormat:@"0%d", hrCountDown];
    if(minCountDown < 10)
        _timerMin.text = [NSString stringWithFormat:@"0%d", minCountDown];
    if(secCountDown < 10)
        _timerSec.text = [NSString stringWithFormat:@"0%d", secCountDown];
}





- (IBAction)resetTimer:(id)sender {
    if(_quickTimer){
        [_quickTimer invalidate];
        _quickTimer = nil;
    }
    _timerSec.text = [NSString stringWithFormat:@"%d", secValue];
    secCountDown = secValue;
    _timerMin.text = [NSString stringWithFormat:@"%d", minValue];
    minCountDown = minValue;
    _timerHr.text = [NSString stringWithFormat:@"%d", hrValue];
    hrCountDown = hrValue;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
