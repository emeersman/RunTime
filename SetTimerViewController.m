//
//  SetTimerViewController.m
//  RunTime
//
//  Created by HMC on 3/3/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "SetTimerViewController.h"
#import "Timer.h"
#import "AppDelegate.h"

@interface SetTimerViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation SetTimerViewController

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
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    _managedObjectContext = appDelegate.managedObjectContext;
    _timerName.delegate = self;
    _timerRepeat.delegate = self;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender == self.saveTimerButtonBar)
    {
        [self saveNewTimer:sender];
    }
}

- (IBAction)addTimer:(id)sender
{
    //Add timer to Saved Timers
    //  Creates, configures, returns an instance of Timer class
    NSManagedObjectContext* context = [self managedObjectContext];
    Timer * newTimer = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Timer"
                        //inManagedObjectContext:self.managedObjectContext];
                        inManagedObjectContext:context];
    //  Add Values to different attributes of Timer
    newTimer.name = _timerName.text;
    int repeats = [_timerRepeat.text intValue];
    newTimer.repeatCount = [NSNumber numberWithInt:repeats];
    
    //  Save entity value to database
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    //  Dismiss keyboard
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *) timerField {
    [self.view endEditing:YES];
    [timerField resignFirstResponder];
    return YES;
}

- (IBAction)saveNewTimer:(id)sender {
    [self addTimer:sender];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
