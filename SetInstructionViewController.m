//
//  SetInstructionViewController.m
//  RunTime
//
//  Created by HMC on 3/25/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "SetInstructionViewController.h"
#import "AppDelegate.h"
#import "Interval.h"
#import "SetTimerViewController.h"

@interface SetInstructionViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation SetInstructionViewController

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
    NSLog(@"timerString is %@", _timerString);
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    _managedObjectContext = appDelegate.managedObjectContext;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

//called before any segue on the SetInstructionViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //will want a transition for saving instructions, as with saving timers
    if (sender == self.saveIntervalButtonBar || sender == self.backButtonBar)
    {
        [self saveNewInstruction:sender];
        
        SetTimerViewController *controller = (SetTimerViewController *)segue.destinationViewController;
        controller.savedTimerString = _timerString;
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *) timerField {
    [self.view endEditing:YES];
    [timerField resignFirstResponder];
    return YES;
}

- (IBAction)addInstruction:(id)sender
{
    //for getting uniqueID
     AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    //add interval to interval list that are in the timer
    NSManagedObjectContext* context = [self managedObjectContext];
    Interval  * newInterval = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Interval"
                               inManagedObjectContext:context];
    
    //add values to different attributes of intervals
    newInterval.name = _instructionName.text;
    int repeats = [_instructionRepeat.text intValue];
    newInterval.repeatCount = [NSNumber numberWithInt: repeats];
    int hours = [_iHour.text intValue];
    int minutes = [_iMinute.text intValue];
    int seconds = [_iSecond.text intValue];
    
    newInterval.hours = [NSNumber numberWithInt:hours];
    newInterval.minutes = [NSNumber numberWithInt:minutes];
    newInterval.seconds = [NSNumber numberWithInt:seconds];
    
    newInterval.id = [NSNumber numberWithInt:[appDelegate getUniqueIDInterval]];
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    //Dismiss keyboard
    [self.view endEditing:YES];
}

- (IBAction)saveNewInstruction:(id)sender
{
    [self addInstruction:sender];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
