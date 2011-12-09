//
//  AppController.m
//  RaiseMan
//
//  Created by Adam Preble on 9/19/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

- (IBAction)showPreferencePanel:(id)sender
{
	// Is preferenceController nil?
	if (!preferenceController) {
		preferenceController = [[PreferenceController alloc] init];
	}
	NSLog(@"showing %@", preferenceController);
	[preferenceController showWindow:self];
}

- (IBAction)showAboutPanel:(id)sender
{
	[NSBundle loadNibNamed:@"About" owner:self];
	[aboutPanel makeKeyAndOrderFront:nil];
}

@end
