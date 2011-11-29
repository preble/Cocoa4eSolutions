//
//  RMDocument.m
//  RaiseMan
//
//  Created by Adam Preble on 9/19/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "RMDocument.h"
#import "Person.h"
#import "PreferenceController.h"

@implementation RMDocument

- (id)init
{
    self = [super init];
    if (self) {
		employees = [[NSMutableArray alloc] init];
		
		NSNotificationCenter *nc =
		[NSNotificationCenter defaultCenter];
		
		[nc addObserver:self
			   selector:@selector(handleColorChange:)
				   name:BNRColorChangedNotification
				 object:nil];
		NSLog(@"Registered with notification center");
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
	[tableView setBackgroundColor:
	 [PreferenceController preferenceTableBgColor]];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	// End editing
	[[tableView window] endEditingFor:nil];
	// Create an NSData object from the employees array
	return [NSKeyedArchiver archivedDataWithRootObject:employees];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	NSLog(@"About to read data of type %@", typeName);
	NSMutableArray *newArray = nil;
	@try {
		newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	@catch (NSException *e) {
		NSLog(@"exception = %@", e);
		if (outError) {
			NSDictionary *d = [NSDictionary
							   dictionaryWithObject:@"The data is corrupted."
							   forKey:NSLocalizedFailureReasonErrorKey];
			*outError = [NSError errorWithDomain:NSOSStatusErrorDomain
											code:unimpErr
										userInfo:d];
		}
		return NO;
	}
	[self setEmployees:newArray];
	return YES;
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

// RMDocumentKVOContext enables this class to differentiate
// between its KVO messages and those intended for a superclass: 
static void *RMDocumentKVOContext;
- (void)startObservingPerson:(Person *)person
{
	[person addObserver:self
			 forKeyPath:@"personName"
				options:NSKeyValueObservingOptionOld
				context:&RMDocumentKVOContext];
	[person addObserver:self
			 forKeyPath:@"expectedRaise"
				options:NSKeyValueObservingOptionOld
				context:&RMDocumentKVOContext];
}
- (void)stopObservingPerson:(Person *)person
{
	[person removeObserver:self
				forKeyPath:@"personName"
				   context:&RMDocumentKVOContext];
	[person removeObserver:self
				forKeyPath:@"expectedRaise"
				   context:&RMDocumentKVOContext];
}

- (void)setEmployees:(NSMutableArray *)a
{
	for (Person *person in employees) {
		[self stopObservingPerson:person];
	}
	
	employees = a;
	
	for (Person *person in employees) {
		[self startObservingPerson:person];
	}
}

- (void)insertObject:(Person *)p inEmployeesAtIndex:(NSUInteger)index {
    NSLog(@"adding %@ to %@", p, employees);
    // Add the inverse of this operation to the undo stack
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self]
	 removeObjectFromEmployeesAtIndex:index];
    if (![undo isUndoing]) {
        [undo setActionName:@"Add Person"];
    }
    // Add the Person to the array
	[self startObservingPerson:p];
    [employees insertObject:p atIndex:index];
}
- (void)removeObjectFromEmployeesAtIndex:(NSUInteger)index
{
    Person *p = [employees objectAtIndex:index];
    NSLog(@"removing %@ from %@", p, employees);
    // Add the inverse of this operation to the undo stack
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] insertObject:p
                                       inEmployeesAtIndex:index];
    if (![undo isUndoing]) {
        [undo setActionName:@"Remove Person"];
	}
	[self stopObservingPerson:p];
    [employees removeObjectAtIndex:index];
}

- (void)changeKeyPath:(NSString *)keyPath
			 ofObject:(id)obj
			  toValue:(id)newValue
{
	// setValue:forKeyPath: will cause the key-value observing method
    // to be called, which takes care of the undo stuff
    [obj setValue:newValue forKeyPath:keyPath];
}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (context != &RMDocumentKVOContext)
    {
		// If the context does not match, this message
        // must be intended for our superclass.
        [super observeValueForKeyPath:keyPath
							 ofObject:object
							   change:change
							  context:context];
		return; }
    NSUndoManager *undo = [self undoManager];
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    // NSNull objects are used to represent nil in a dictionary
    if (oldValue == [NSNull null]) {
        oldValue = nil;
    }
    NSLog(@"oldValue = %@", oldValue);
    [[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath
                                                  ofObject:object
                                                   toValue:oldValue];
    [undo setActionName:@"Edit"];
}

- (IBAction)createEmployee:(id)sender
{
    NSWindow *w = [tableView window];
    // Try to end any editing that is taking place
    BOOL editingEnded = [w makeFirstResponder:w];
    if (!editingEnded) {
        NSLog(@"Unable to end editing");
		return; }
    NSUndoManager *undo = [self undoManager];
    // Has an edit occurred already in this event?
    if ([undo groupingLevel] > 0) {
        // Close the last group
        [undo endUndoGrouping];
        // Open a new group
        [undo beginUndoGrouping];
    }
    // Create the object
    Person *p = [employeeController newObject];
    // Add it to the content array of ’employeeController’
    [employeeController addObject:p];
    // Re-sort (in case the user has sorted a column)
    [employeeController rearrangeObjects];
    // Get the sorted array
    NSArray *a = [employeeController arrangedObjects];
    // Find the object just added
    NSUInteger row = [a indexOfObjectIdenticalTo:p];
    NSLog(@"starting edit of %@ in row %lu", p, row);
    // Begin the edit in the first column
    [tableView editColumn:0
					  row:row
				withEvent:nil
				   select:YES];
}

- (IBAction)removeEmployee:(id)sender
{
	NSArray *selectedPeople = [employeeController selectedObjects];
	NSAlert *alert = [NSAlert
					  alertWithMessageText:NSLocalizedString(@"REMOVE_MSG", @"Remove")
                      defaultButton:NSLocalizedString(@"REMOVE", @"Remove")
					  alternateButton:NSLocalizedString(@"CANCEL", @"Cancel")
					  otherButton:nil
					  informativeTextWithFormat:NSLocalizedString(@"REMOVE_INF",
																  @"%d people will be removed."),
					  [selectedPeople count]];
	NSLog(@"Starting alert sheet");
	[alert beginSheetModalForWindow:[tableView window]
					  modalDelegate:self
					 didEndSelector:@selector(alertEnded:code:context:)
						contextInfo:NULL];
}

- (void)alertEnded:(NSAlert *)alert
			  code:(NSInteger)choice
		   context:(void *)v
{
	NSLog(@"Alert sheet ended");
	// If the user chose "Remove", tell the array controller to
	// delete the people
	if (choice == NSAlertDefaultReturn) {
		// The argument to remove: is ignored
		// The array controller will delete the selected objects
		[employeeController remove:nil];
	}
}

- (void)handleColorChange:(NSNotification *)note
{
	NSLog(@"Received notification: %@", note);
	NSColor *color = [[note userInfo] objectForKey:@"color"];
	[tableView setBackgroundColor:color];
}

@end
