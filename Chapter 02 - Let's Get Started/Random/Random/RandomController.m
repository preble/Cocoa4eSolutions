//
//  RandomController.m
//  Random
//
//  Created by Adam Preble on 9/9/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "RandomController.h"

@implementation RandomController

- (void)awakeFromNib
{
	NSDate *now;
	now = [NSDate date];
	[textField setObjectValue:now];
}

- (IBAction)generate:(id)sender
{
	// Generate a number between 1 and 100 inclusive
	int generated;
	generated = (int)(random() % 100) + 1;
	NSLog(@"generated = %d", generated);
	// Ask the text field to change what it is displaying
	[textField setIntValue:generated];
}

- (IBAction)seed:(id)sender
{
	// Seed the random number generator with the time
	srandom((unsigned)time(NULL));
	[textField setStringValue:@"Generator seeded"];
}

@end
