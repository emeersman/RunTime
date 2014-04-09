//
//  RunTimerViewController.m
//  RunTime
//
//  Created by HMC on 3/25/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "RunTimerViewController.h"
#import "Timer.h"
#import "Interval.h"
#import "AppDelegate.h"

@interface RunTimerViewController ()

@property (nonatomic, strong)NSArray* fetchedIntervalsArray;

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
int STATIC_CELLS = 1; //not a magic number! The "new" button.


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
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetch instructions array when transitioning from SavedTimer
    _fetchedIntervalsArray = [appDelegate getAllSavedIntervals];
    [_miniTableView reloadData];// This SHOULD load them into the table, but something's up
    
    ///hacky hack from SavedTimers
    [_miniTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    // Pre-populate text fields with timer name and repeats
    _timerName.text = selectTimer.name;
    _timerReps.text = [selectTimer.repeatCount stringValue];
    
    
    [self updateInstruction];
    
    // User can't edit any of these field in this window
    _timerName.userInteractionEnabled = NO;
    _timerReps.userInteractionEnabled = NO;
    _instrId.userInteractionEnabled = NO;
    _instrReps.userInteractionEnabled = NO;
    _timerHr.userInteractionEnabled = NO;
    _timerMin.userInteractionEnabled = NO;
    _timerSec.userInteractionEnabled = NO;
}

// Depending on what instruction we're on, sets text field values for that instruction
-(void) updateInstruction
{
    if([selectTimer.instructions count] > 0)
    {
        Interval *tempInstr = [selectTimer.instructions objectAtIndex:currInstr];
        _instrId.text = tempInstr.name;
        _timerHr.text = [tempInstr.hours stringValue];
        _timerMin.text = [tempInstr.minutes stringValue];
        _timerSec.text = [tempInstr.seconds stringValue];
        _instrReps.text = [tempInstr.repeatCount stringValue];
    }
}

//Dealing with the mini table view on the screen
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_fetchedIntervalsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Interval* interval = [_fetchedIntervalsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, Seconds %@", interval.name, interval.repeatCount];
    
    return cell;
}

// What happens when we press run!
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

// This happens every tick of the timer, deals with instructions, reps, etc.
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
                    --instrCountDown; // set visual display of instr to be one less, as well
                    //reset timer for that instr
                    [self updateInstruction];
                    // start the timer
                } else { // else go to next instruction, if there is one
                    if(currInstr < [selectTimer.instructions count] - 1)
                    {
                        ++currInstr;
                        [self updateInstruction];
                    } else { //check if timer still needs to be repeated
                        if (repCountDown > 0)
                        {
                         --repCountDown;
                         currInstr = 0;
                         [self updateInstruction];
                         //start timer with next instruction
                        }
                    }
                }
            }
        }
    }
    // Puts zeros in tens place when necessary
    if(hrCountDownC < 10)
        _timerHr.text = [NSString stringWithFormat:@"0%d", hrCountDownC];
    if(minCountDownC < 10)
        _timerMin.text = [NSString stringWithFormat:@"0%d", minCountDownC];
    if(secCountDownC < 10)
        _timerSec.text = [NSString stringWithFormat:@"0%d", secCountDownC];

}

// Reset button is pressed!
- (IBAction)resetTimer:(id)sender {
    if(_currTimer){
        [_currTimer invalidate];
        _currTimer = nil;
    }
    currInstr = 0;
    [self updateInstruction];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end