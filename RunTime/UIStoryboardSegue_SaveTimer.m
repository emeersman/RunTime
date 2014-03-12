//
//  UIStoryboardSegue_SaveTimer.m
//  RunTime
//
//  Created by Laptop 24 on 3/11/14.
//  Copyright (c) 2014 HMC. All rights reserved.
//

#import "UIStoryboardSegue_SaveTimer.h"

@implementation UIStoryboardSegue_SaveTimer


- (void)perform
{
    // Add your own animation code here.
    
    
    
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
}

@end
