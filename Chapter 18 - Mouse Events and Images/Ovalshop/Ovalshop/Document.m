//
//  Document.m
//  Ovalshop
//
//  Created by Adam Preble on 12/8/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "Document.h"
#import "OvalView.h"

@implementation Document
@synthesize ovalView;
@synthesize ovals;

- (id)init
{
    self = [super init];
    if (self) {
		// Add your subclass-specific initialization here.
		// If an error occurs here, return nil.
		ovals = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)windowNibName
{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
}

#pragma mark - External API

- (void)addOvalWithRect:(NSRect)rect
{
	[[[self undoManager] prepareWithInvocationTarget:self] removeLastOval];
	
	if (![[self undoManager] isUndoing])
		[[self undoManager] setActionName:@"Add Oval"];
	
	[ovals addObject:[NSValue valueWithRect:rect]];
	[ovalView setNeedsDisplay:YES];
}

- (void)removeLastOval
{
	if ([ovals count] == 0)
		return;
	
	NSValue *lastOvalValue = [ovals lastObject];
	[[[self undoManager] prepareWithInvocationTarget:self] addOvalWithRect:[lastOvalValue rectValue]];
	
	[ovals removeLastObject];
	[ovalView setNeedsDisplay:YES];
}

#pragma mark - File I/O

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	return [NSKeyedArchiver archivedDataWithRootObject:ovals];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	ovals = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	[ovalView setNeedsDisplay:YES];
	return YES;
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

@end
