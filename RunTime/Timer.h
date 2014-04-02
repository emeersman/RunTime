//
//  Timer.h
//  RunTime
//
//  Created by Laptop 24 on 4/1/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Interval;

@interface Timer : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * repeatCount;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSOrderedSet *instructions;
@end

@interface Timer (CoreDataGeneratedAccessors)

- (void)insertObject:(Interval *)value inInstructionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromInstructionsAtIndex:(NSUInteger)idx;
- (void)insertInstructions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeInstructionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInInstructionsAtIndex:(NSUInteger)idx withObject:(Interval *)value;
- (void)replaceInstructionsAtIndexes:(NSIndexSet *)indexes withInstructions:(NSArray *)values;
- (void)addInstructionsObject:(Interval *)value;
- (void)removeInstructionsObject:(Interval *)value;
- (void)addInstructions:(NSOrderedSet *)values;
- (void)removeInstructions:(NSOrderedSet *)values;
@end
