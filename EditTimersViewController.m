//
//  EditTimersViewController.m
//  RunTime
//
//  Created by HMC on 3/25/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "EditTimersViewController.h"
#import "SavedTimersViewController.h"
#import "AppDelegate.h"
#import "RunTimerViewController.h"
#import "Timer.h"
#import "EditSingleTimerViewController.h"

@interface EditTimersViewController ()

@property (nonatomic, strong)NSArray* fetchedTimersArray;

@end

Timer *temptTimer;
NSIndexPath *indexP1 = 0;
int NUM_OF_STATIC_CELLS = 1; //not a magic number! The "new" button.

@implementation EditTimersViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    _fetchedTimersArray = [appDelegate getAllSavedTimers];
    [self.tableView reloadData];
    
    ///hacky hack?
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_fetchedTimersArray count];
}

// Put all timers from the array into the table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //STATIC CELL - hard to test when we can't actually go here.
    //Doesn't actually work, but the displayed table might not be quite right either.
    //Might be visually correct, but might need adjustment to get to details to be shifted as well.
    if (indexPath.row < NUM_OF_STATIC_CELLS)
    {
        cell.textLabel.text = @"New";
    }
    
    Timer* timer = [_fetchedTimersArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",timer.name];
    //cell.textLabel.text = [NSString stringWithFormat:@"%@, Repeat %@", timer.name, timer.repeatCount];
    
    // Configure the cell...
    
    return cell;
}

// Handles navigation to the RunTimer screen and gets data from selected row
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    temptTimer = [_fetchedTimersArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"editSavedTimer" sender:self];
}

// Passes data from selected row to RunTimerViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if (sender != self.backBarButto)
    EditSingleTimerViewController *destViewController = segue.destinationViewController;
    destViewController.selectTimer = temptTimer;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end
