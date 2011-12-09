//
//  Person.m
//  RaiseMan
//
//  Created by Adam Preble on 9/19/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize personName;
@synthesize expectedRaise;

- (id)init {
    self = [super init];
    if (self) {
        expectedRaise = 0.05;
		personName = @"New Person";
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if (self) {
		personName = [coder decodeObjectForKey:@"personName"];
		expectedRaise = [coder decodeFloatForKey:@"expectedRaise"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:personName forKey:@"personName"];
    [coder encodeFloat:expectedRaise forKey:@"expectedRaise"];
}

- (void)setNilValueForKey:(NSString *)key
{
	if ([key isEqual:@"expectedRaise"]) {
		[self setExpectedRaise:0.0];
	} else {
		[super setNilValueForKey:key];
	}
}

@end
