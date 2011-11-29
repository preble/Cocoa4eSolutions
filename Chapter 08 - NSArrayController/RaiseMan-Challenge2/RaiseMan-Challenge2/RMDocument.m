//
//  RMDocument.m
//  RaiseMan-Challenge2
//
//  Created by Adam Preble on 11/29/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "RMDocument.h"
#import "Person.h"

@implementation RMDocument

- (id)init
{
    self = [super init];
    if (self) {
		// Add your subclass-specific initialization here.
		// If an error occurs here, return nil.
		employees = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)windowNibName
{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"RMDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	/*
	 Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
	You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
	*/
	NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
	@throw exception;
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	/*
	Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
	You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
	If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
	*/
	NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
	@throw exception;
	return YES;
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

#pragma mark - Actions

- (IBAction)deleteSelectedEmployee:(id)sender
{
	// Which row is selected?
	NSIndexSet *rows = [tableView selectedRowIndexes];
	
	// Is the selection empty?
	if ([rows count] == 0)
	{
		NSBeep();
		return;
	}
	
	[employees removeObjectsAtIndexes:rows];
	[tableView reloadData];
}

- (IBAction)createEmployee:(id)sender
{
	Person *newEmployee = [[Person alloc] init];
	[employees addObject:newEmployee];
	[tableView reloadData];
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return [employees count];
}

- (id)tableView:(NSTableView *)theTableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	Person *employee = [employees objectAtIndex:row];
	return [employee valueForKey:[tableColumn identifier]];
}

-(void)tableView:(NSTableView *)theTableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	Person *employee = [employees objectAtIndex:row];
	[employee setValue:object forKey:[tableColumn identifier]];
}

- (void)tableView:(NSTableView *)theTableView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{
	[employees sortUsingDescriptors:[tableView sortDescriptors]];
	[tableView reloadData];
}

@end
