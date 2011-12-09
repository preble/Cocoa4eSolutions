//
//  RanchForecastAppDelegate.m
//  RanchForecast
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "RanchForecastAppDelegate.h"
#import "ScheduleFetcher.h"
#import "ScheduledClass.h"
#import "WebWindowController.h"

@implementation RanchForecastAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[tableView setTarget:self];
	[tableView setDoubleAction:@selector(openClass:)];
	
	ScheduleFetcher *fetcher = [[ScheduleFetcher alloc] init];
    NSError *error = nil;
	classes = [fetcher fetchClassesWithError:&error];
	[tableView reloadData];
}

- (void)openClass:(id)sender
{
	ScheduledClass *c = [classes objectAtIndex:[tableView clickedRow]];
	NSURL *baseUrl = [NSURL URLWithString:@"http://www.bignerdranch.com/"];
	NSURL *url = [NSURL URLWithString:[c href] relativeToURL:baseUrl];
	
	webWindowController = [[WebWindowController alloc] init];
	[NSApp beginSheet:[webWindowController window] modalForWindow:[self window] modalDelegate:nil didEndSelector:nil contextInfo:NULL];
	[webWindowController openURL:url];
//	[[NSWorkspace sharedWorkspace] openURL:url];
}

#pragma mark -
#pragma mark NSTableViewDataSource


- (NSInteger)numberOfRowsInTableView:(NSTableView *)theTableView {
	return [classes count];
}

- (id)tableView:(NSTableView *)theTableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
			row:(NSInteger)row
{
	ScheduledClass *c = [classes objectAtIndex:row];
	return [c valueForKey:[tableColumn identifier]];
}

@end
