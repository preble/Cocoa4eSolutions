//
//  TodoController.m
//  TodoChallenge
//
//  Created by Adam Preble on 11/29/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "TodoController.h"

@implementation TodoController

@synthesize items;
@synthesize itemInputField;
@synthesize tableView;

- (id)init
{
    self = [super init];
    if (self) {
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    itemInputField = nil;
	tableView = nil;
}

#pragma mark - Actions

- (IBAction)add:(id)sender
{
	NSString *text = [[self itemInputField] stringValue];
	[[self itemInputField] setStringValue:@""];
	[[self items] addObject:text];
	[[self tableView] reloadData];
	[[self tableView] scrollRowToVisible:[[self items] count] - 1];
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return [[self items] count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	NSString *text = [[self items] objectAtIndex:row];
	return text;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	[[self items] replaceObjectAtIndex:row withObject:object];
}

@end
