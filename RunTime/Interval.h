//
//  Interval.h
//  RunTime
//
//  Created by Laptop 24 on 3/24/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Interval : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * hours;
@property (nonatomic, retain) NSNumber * minutes;
@property (nonatomic, retain) NSNumber * seconds;
@property (nonatomic, retain) NSNumber * repeatCount;

@end
