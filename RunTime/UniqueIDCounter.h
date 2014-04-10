//
//  UniqueIDCounter.h
//  RunTime
//
//  Created by Laptop 24 on 4/9/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UniqueIDCounter : NSManagedObject

@property (nonatomic, retain) NSNumber * timerID;
@property (nonatomic, retain) NSNumber * intervalID;

@end
