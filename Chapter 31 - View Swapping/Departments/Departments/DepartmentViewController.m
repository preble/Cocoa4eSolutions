//
//  DepartmentViewController.m
//  Departments
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "DepartmentViewController.h"

@implementation DepartmentViewController

- (id)init {
	self = [super initWithNibName:@"DepartmentView"
						   bundle:nil];
	if (self) {
		[self setTitle:@"Departments"];
	}
	return self;
}

@end
