//
//  EditSingleTimerViewController.m
//  RunTime
//
//  Created by Sarah Scheffler on 4/22/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "EditSingleTimerViewController.h"
#import "Timer.h"
#import "Interval.h"
#import "AppDelegate.h"

@interface EditSingleTimerViewController ()

@property (nonatomic, strong) NSArray* fetchedIntervalsArray;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation EditSingleTimerViewController

@synthesize selectTimer;

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
    // Do any additional setup after loading the view.
    
    // Fetch instructions array when transitioning from SavedTimer
    _fetchedIntervalsArray = [selectTimer.instructions array];
    
    [_instructionTable reloadData];
    
    //hacky hack from SavedTimers
    [_instructionTable registerClass:[UITableViewCell class]forCellReuseIdentifier:@"Cell"];
    
    //Pre-populate text fields with timer name and repeats
    _timerNameField.text = selectTimer.name;
    _repeatNumber.text = [selectTimer.repeatCount stringValue];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (self.saveBarButton == sender)
    {
        //change fields to match!
        selectTimer.name = _timerNameField.text;
        int repeatNum = [_repeatNumber.text intValue];
        selectTimer.repeatCount = [NSNumber numberWithInt:repeatNum];
        
        NSError * error;
        
        [_managedObjectContext save:&error];
        [[_managedObjectContext parentContext] save:&error];
        
        //shrug
    }
    
    if (sender == self.deleteButton)
    {
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate deleteTimer:selectTimer.id];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//dealing with tableview
-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
    //return number of sections
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return the number of rows in the section
    return [_fetchedIntervalsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Interval* interval = [_fetchedIntervalsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, ID %@", interval.name, interval.id];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
