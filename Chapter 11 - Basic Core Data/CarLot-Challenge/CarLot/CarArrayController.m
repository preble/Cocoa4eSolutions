//
//  CarArrayController.m
//  CarLot
//
//  Created by Adam Preble on 9/19/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "CarArrayController.h"

@implementation CarArrayController

- (id)newObject
{
	id newObj = [super newObject];
	NSDate *now = [NSDate date];
	[newObj setValue:now forKey:@"datePurchased"];
	return newObj;
}

@end
