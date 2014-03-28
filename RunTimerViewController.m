//
//  RunTimerViewController.m
//  RunTime
//
//  Created by HMC on 3/25/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "RunTimerViewController.h"
#import "Timer.h"

@interface RunTimerViewController ()

@end

@implementation RunTimerViewController

@synthesize selectTimer;
int currInstr = 0;

int secValueC = 0;
int secCountDownC = 0;
int minValueC = 0;
int minCountDownC = 0;
int hrValueC = 0;
int hrCountDownC = 0;
int instrValue = 0;
int instrCountDown = 0;
int repValue = 0;
int repCountDown = 0;
BOOL startedC = NO;

int alarmOnC = 0;

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
    _timerName.text = selectTimer.name;
    _timerReps.text = [selectTimer.repeatCount stringValue];
    //[updateInstruction];
}

-(void) updateInstruction
{
    /*_instrId.text = [selectTimer.instructions[currInstr].name];
     _timerHr.text = [selectTimer.instructions[currInstr].hours stringValue];
     _timerMin.text = [selectTimer.instructions[currInstr].minutes stringValue];
     _timerSec.text = [selectTimer.instructions[currInstr].seconds stringValue];
     _instrReps.text = [selectTimer.instructions[currInstr].repeatCount stringValue]*/
}

- (IBAction)beginTimer:(id)sender {
    if (!startedC) {
        _currTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:self
                                                         selector:@selector(updateTimer:)
                                                         userInfo:nil
                                                          repeats:YES];
        
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: _currTimer forMode: NSDefaultRunLoopMode];
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        startedC = YES;
    }
    else {
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        startedC = NO;
        if(_currTimer){
            [_currTimer invalidate];
            _currTimer = nil;
        }
    }
    
}

-(void)updateTimer:(NSTimer *)timer {
    if(hrCountDownC > 0)
    {
        if(minCountDownC == 0 && secCountDownC == 0)
        {
            self.timerHr.text = [NSString stringWithFormat:@"%d", --hrCountDownC];
            self.timerMin.text = [NSString stringWithFormat:@"%d", 59];
            self.timerSec.text = [NSString stringWithFormat:@"%d", 59];
            minCountDownC = 59;
            secCountDownC = 59;
        } else {
            if(minCountDownC > 0) {
                if(secCountDownC == 0) {
                    self.timerMin.text = [NSString stringWithFormat:@"%d", --minCountDownC];
                    self.timerSec.text = [NSString stringWithFormat:@"%d", 59];
                    secCountDownC = 59;
                } else
                {
                    self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDownC];
                }
            } else{
                self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDownC];
            }
        }
    } else {
        if(minCountDownC > 0) {
            if(secCountDownC == 0) {
                self.timerMin.text = [NSString stringWithFormat:@"%d", --minCountDownC];
                self.timerSec.text = [NSString stringWithFormat:@"%d", 59];
                secCountDownC = 59;
            } else
            {
                self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDownC];
            }
        } else{
            if(secCountDownC > 0)
            {
                self.timerSec.text = [NSString stringWithFormat:@"%d", --secCountDownC];
                
                if (alarmOnC != 0)
                {
                    alarmOnC = 0;
                }
            } else //zero things
            {
                if (alarmOnC == 0) //readd this statement if we only want the alarm to sound once
                {
                    //AudioServicesPlayAlertSound(alarmSound);
                    
                    alarmOnC++;
                }
                // if instruction repeat is above 0, repeat that instruction again
                if (instrCountDown > 0)
                {
                    --instrCountDown;
                    //reset timer for that instr
                    //[updateInstruction];
                    // start the timer
                } else { // else go to next instruction, if there is one
                    //if currInstr > instructions.length-1, ++currInstr
                    //else check if timer still needs to be repeated
                    /*if (repCountDown > 0)
                     {
                     --repCountDown;
                     currInstr = 0;
                     //[updateInstruction];
                     //start timer with next instruction
                     } else {
                     
                     }*/
                }
            }
        }
    }
    if(hrCountDownC < 10)
        _timerHr.text = [NSString stringWithFormat:@"0%d", hrCountDownC];
    if(minCountDownC < 10)
        _timerMin.text = [NSString stringWithFormat:@"0%d", minCountDownC];
    if(secCountDownC < 10)
        _timerSec.text = [NSString stringWithFormat:@"0%d", secCountDownC];

}



- (IBAction)resetTimer:(id)sender {
    if(_currTimer){
        [_currTimer invalidate];
        _currTimer = nil;
    }
    currInstr = 0;
    //[updateInstruction];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
