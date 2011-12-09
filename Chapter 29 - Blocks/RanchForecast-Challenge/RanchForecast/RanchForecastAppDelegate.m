//
//  RanchForecastAppDelegate.m
//  RanchForecast
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "RanchForecastAppDelegate.h"
#import "ScheduledClass.h"

@implementation RanchForecastAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[tableView setTarget:self];
	[tableView setDoubleAction:@selector(openClass:)];
	
	ScheduleFetcher *fetcher = [[ScheduleFetcher alloc] init];
	[fetcher setDelegate:self];
	[fetcher fetchClasses];
}

- (void)openClass:(id)sender
{
	ScheduledClass *c = [classes objectAtIndex:[tableView clickedRow]];
	NSURL *baseUrl = [NSURL URLWithString:@"http://www.bignerdranch.com/"];
	NSURL *url = [NSURL URLWithString:[c href] relativeToURL:baseUrl];
	[[NSWorkspace sharedWorkspace] openURL:url];
}

#pragma mark - ScheduleFetcherDelegate

- (void)scheduleFetcher:(ScheduleFetcher *)sf fetchedClasses:(NSArray *)theClasses
{
	classes = theClasses;
	[tableView reloadData];
}

- (void)scheduleFetcher:(ScheduleFetcher *)sf didFailWithError:(NSError *)error
{
	NSAlert *alert = [[NSAlert alloc] init];
	[alert setAlertStyle:NSCriticalAlertStyle];
	[alert setMessageText:@"Error loading schedule."];
	[alert setInformativeText:[error localizedDescription]];
	[alert addButtonWithTitle:@"OK"];
	[alert beginSheetModalForWindow:self.window
					  modalDelegate:nil
					 didEndSelector:nil
						contextInfo:nil];
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
