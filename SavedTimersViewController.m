//
//  SavedTimersViewController.m
//  RunTime
//
//  Created by HMC on 3/3/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "SavedTimersViewController.h"
#import "AppDelegate.h"
#import "RunTimerViewController.h"
#import "Timer.h"

@interface SavedTimersViewController ()

@property (nonatomic, strong)NSArray* fetchedTimersArray;

@end

NSIndexPath *indexP = 0;
Timer *tempTimer;
int NUMBER_OF_STATIC_CELLS = 1; //not a magic number! The "new" button.

@implementation SavedTimersViewController

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //STATIC CELL - hard to test when we can't actually go here.
    //Doesn't actually work, but the displayed table might not be quite right either.
    //Might be visually correct, but might need adjustment to get to details to be shifted as well.
    if (indexPath.row < NUMBER_OF_STATIC_CELLS)
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
    tempTimer = [_fetchedTimersArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"runSavedTimer" sender:self];
}

// Passes data from selected row to RunTimerViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // If the edit button is pressed, we don't need to create any new objects, just go to Edit Timers
    if(sender != self.editBarButton)
    {
        RunTimerViewController *destViewController = segue.destinationViewController;
        destViewController.selectTimer = tempTimer;
    }
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
