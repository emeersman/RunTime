//
//  Interval.h
//  RunTime
//
//  Created by Laptop 24 on 4/5/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Timer;

@interface Interval : NSManagedObject

@property (nonatomic, retain) NSNumber * hours;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * minutes;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * repeatCount;
@property (nonatomic, retain) NSNumber * seconds;
@property (nonatomic, retain) Timer *timer;

@end
