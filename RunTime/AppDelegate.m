//
//  AppDelegate.m
//  RunTime
//
//  Created by HMC on 2/23/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "AppDelegate.h"
#import "Timer.h"
#import "Interval.h"
#import "UniqueIDCounter.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UniqueIDCounter *uniqueIDCounter;
    
    //in theory this is a fetch request which let's us look and see if something is there or not
    //with the label "UniqueIDCounter" to see if we need to create one (first time app is being
    //run) or if it already exists and we should just leave it alone
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (context == nil)
    {
        NSLog(@"context is nil");
    }
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UniqueIDCounter" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSUInteger count = [context countForFetchRequest:request error:&error];
    //[request release]; //apparently "ARC" does this for us, but leaving it here for reference
    
    if (count == NSNotFound) {
        //doesn't exist, so we create it
        uniqueIDCounter = [NSEntityDescription insertNewObjectForEntityForName:@"UniqueIDCounter"
                                                        inManagedObjectContext:context];
        uniqueIDCounter.timerID = [NSNumber numberWithInt:1];
        uniqueIDCounter.intervalID = [NSNumber numberWithInt:1];
    }
    
    /*
     NSManagedObjectContext* context = [self managedObjectContext];
     Timer *failedTimer = [NSEntityDescription insertNewObjectForEntityForName:@"Timer" inManagedObjectContext:context];
     failedTimer.name = @"BLAHHH";
     
     NSError *error;
     if (![self.managedObjectContext save:&error]) {
     NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
     } */
    
    return YES;
        
}
    


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"Timer.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSArray*) getAllSavedTimers {
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Timer"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}

-(NSArray*) getAllSavedIntervals {
    //initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [ [NSFetchRequest alloc] init];
    
    //setting entity to be queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Interval"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    //query on managedObjectContext with Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    //returning fetched records
    return fetchedRecords;
}

-(UniqueIDCounter*) getUniqueID {
    //initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [ [NSFetchRequest alloc] init];
    
    //setting entity to be queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UniqueIDCounter"
                                              inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    NSError* error;
    
    //query on managedObjectContext with Generated fetchRequest
    UniqueIDCounter* uniqueIDCounter = [self.managedObjectContext
                                        executeFetchRequest:fetchRequest error:&error][0];
    
    return uniqueIDCounter;
}


@end
