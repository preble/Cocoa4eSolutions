//
//  EmployeeViewController.m
//  Departments
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "EmployeeViewController.h"

@implementation EmployeeViewController

- (id)init {
	self = [super initWithNibName:@"EmployeeView"
						   bundle:nil];
	if (self) {
		[self setTitle:@"Employees"];
	}
	return self;
}

@end
