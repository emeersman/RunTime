//
//  Timer.h
//  RunTime
//
//  Created by HMC on 3/3/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Timer : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * repeatCount;

@end
