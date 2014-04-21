//
//  SetTimerViewController.m
//  RunTime
//
//  Created by HMC on 3/3/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "SetTimerViewController.h"
#import "Timer.h"
#import "Interval.h"
#import "AppDelegate.h"

@interface SetTimerViewController ()

//for table of instructions
@property (nonatomic, strong)NSArray* fetchedIntervalsArray;

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
    [super viewDidLoad];
    
    _fetchedIntervalsArray = [appDelegate getAllUnlinkedIntervals];
    [_intervalTable reloadData];
    
    //hacky hack from SavedTimersViewController.m
    [_intervalTable registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"Cell"];
}

- (BOOL)textFieldShouldReturn:(UITextField *) timerField {
    [self.view endEditing:YES];
    [timerField resignFirstResponder];
    return NO;
}

// this function is called before any segue on the SetTimerViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //this is for saving the timer, which requires calling a function and then
    //pushing the segue
    if (sender == self.saveTimerButtonBar)
    {
        [self saveNewTimer:sender];
        
        NSError * error;
        
        [_managedObjectContext save:&error];
        [[_managedObjectContext parentContext] save:&error];
    }
    
    if (sender == self.backButtonBar)
    {
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate deleteUnlinkedIntervals];
    }
}

- (IBAction)addTimer:(id)sender
{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    //Add timer to Saved Timers
    //  Creates, configures, returns an instance of Timer class
    NSManagedObjectContext* context = [self managedObjectContext];
    Timer * newTimer = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Timer"
                        inManagedObjectContext:context];
    //  Add Values to different attributes of Timer
    newTimer.name = _timerName.text;
    int repeats = [_timerRepeat.text intValue];
    newTimer.repeatCount = [NSNumber numberWithInt:repeats];
    
    newTimer.id = [NSNumber numberWithInt:[appDelegate getUniqueIDTimer]];
    
    [appDelegate markAllUnlinkedIntervals];
    
    //in theory adding the interval to the timer!
    //[newTimer addInstructionsObject:intervalToAdd];
    
    // Take the array of intervals, save it to the new timer being constructed
    newTimer.instructions = [NSOrderedSet orderedSetWithArray:_fetchedIntervalsArray];
    
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    //  Dismiss keyboard
    [self.view endEditing:YES];
}

/*
 * doesn't seem to do anything
- (BOOL)textFieldShouldReturn:(UITextField *) timerField {
    [self.view endEditing:YES];
    [timerField resignFirstResponder];
    return YES;
}
 */

- (IBAction)saveNewTimer:(id)sender {
    [self addTimer:sender];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
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
    
    //STATIC CELL - hard to test when we can't actually go here.
    //Doesn't actually work, but the displayed table might not be quite right either.
    //Might be visually correct, but might need adjustment to get to details to be shifted as well.
    /* if (indexPath.row < NUMBER_OF_STATIC_CELLS)
    {
        cell.textLabel.text = @"New";
    } */
    
    Interval* interval = [_fetchedIntervalsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, ID %@", interval.name, interval.id];
    
    // Configure the cell...
    
    return cell;
}

@end
