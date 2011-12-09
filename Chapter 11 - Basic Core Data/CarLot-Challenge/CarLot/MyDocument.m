//
//  MyDocument.m
//  CarLot
//
//  Created by Adam Preble on 9/19/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
		// Add your subclass-specific initialization here.
		// If an error occurs here, return nil.
    }
    return self;
}

- (NSString *)windowNibName
{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (IBAction)createCar:(id)sender
{
    NSWindow *w = [tableView window];
    // Try to end any editing that is taking place
    BOOL editingEnded = [w makeFirstResponder:w];
    if (!editingEnded)
	{
        NSLog(@"Unable to end editing");
		return;
	}
    NSUndoManager *undo = [self undoManager];
    // Has an edit occurred already in this event?
    if ([undo groupingLevel] > 0) {
        // Close the last group
        [undo endUndoGrouping];
        // Open a new group
        [undo beginUndoGrouping];
    }
    // Create the object
    id p = [carsController newObject];
    // Add it to the content array of ’carsController’
    [carsController addObject:p];
    // Re-sort (in case the user has sorted a column)
    [carsController rearrangeObjects];
    // Get the sorted array
    NSArray *a = [carsController arrangedObjects];
    // Find the object just added
    NSUInteger row = [a indexOfObjectIdenticalTo:p];
    NSLog(@"starting edit of %@ in row %lu", p, row);
    // Begin the edit in the first column
    [tableView editColumn:0
					  row:row
				withEvent:nil
				   select:YES];
}


@end
