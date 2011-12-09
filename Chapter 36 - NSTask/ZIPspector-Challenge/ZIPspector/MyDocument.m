//
//  MyDocument.m
//  ZIPspector
//
//  Created by Adam Preble on 9/22/11.
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

- (BOOL)readFromURL:(NSURL *)absoluteURL
             ofType:(NSString *)typeName
              error:(NSError **)outError
{
    // Which file are we getting the zipinfo for?
    NSString *filename = [absoluteURL path];
	
	NSString *launchPath = nil;
	NSArray *args = nil;
	
	if ([typeName isEqualToString:@"com.pkware.zip-archive"] || [typeName isEqualToString:@"public.zip-archive"])
	{
		launchPath = @"/usr/bin/zipinfo";
		args = [NSArray arrayWithObjects:@"-1", filename, nil];
	}
	else if ([typeName isEqualToString:@"public.tar-archive"])
	{
		launchPath = @"/usr/bin/tar";
		args = [NSArray arrayWithObjects:@"tf", filename, nil];
	}
	else if ([typeName isEqualToString:@"org.gnu.gnu-zip-tar-archive"] || [typeName isEqualToString:@"org.gnu.gnu-zip-archive"])
	{
		launchPath = @"/usr/bin/tar";
		args = [NSArray arrayWithObjects:@"tzf", filename, nil];
	}
	else
	{
		if (outError) {
			NSDictionary *eDict = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Unrecognized file type %@", typeName]
															  forKey:NSLocalizedFailureReasonErrorKey];
			*outError = [NSError errorWithDomain:NSOSStatusErrorDomain
											code:0
										userInfo:eDict];
		}
		return NO;
	}
	
    // Prepare a task object
	NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath:launchPath];
	[task setArguments:args];
	
	// Create the pipe to read from
	NSPipe *outPipe = [[NSPipe alloc] init];
	[task setStandardOutput:outPipe];
	
	// Start the process
	[task launch];
	
	// Read the output
	NSData *data = [[outPipe fileHandleForReading] readDataToEndOfFile];
	
	// Make sure the task terminates normally
	[task waitUntilExit];
	int status = [task terminationStatus];
	
	// Check status
	if (status != 0) {
		if (outError) {
			NSDictionary *eDict = [NSDictionary dictionaryWithObject:@"zipinfo failed"
															  forKey:NSLocalizedFailureReasonErrorKey];
			*outError = [NSError errorWithDomain:NSOSStatusErrorDomain
											code:0
										userInfo:eDict];
		}
		return NO;
	}
    
	// Convert to a string
    NSString *aString = [[NSString alloc] initWithData:data
											  encoding:NSUTF8StringEncoding];
    
	// Break the string into lines
    filenames = [aString componentsSeparatedByString:@"\n"];
    NSLog(@"filenames = %@", filenames);
    
	// In case of revert
    [tableView reloadData];
	
	return YES;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)v
{
    return [filenames count];
}

- (id)tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tc
			row:(NSInteger)row
{
    return [filenames objectAtIndex:row];
}

@end
