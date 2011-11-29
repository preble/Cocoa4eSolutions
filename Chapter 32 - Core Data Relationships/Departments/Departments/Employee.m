//
//  Employee.m
//  Departments
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "Employee.h"
#import "Department.h"


@implementation Employee

@dynamic firstName;
@dynamic lastName;
@dynamic department;

+ (NSSet *)keyPathsForValuesAffectingFullName
{
	return [NSSet setWithObjects:@"firstName", @"lastName", nil];
}

- (NSString *)fullName
{
	NSString *first = [self firstName];
	NSString *last = [self lastName];
	if (!first)
		return last;
	if (!last)
		return first;
	return [NSString stringWithFormat:@"%@ %@", first, last];
}

@end
