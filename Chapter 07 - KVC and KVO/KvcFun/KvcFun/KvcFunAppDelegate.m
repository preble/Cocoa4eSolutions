//
//  KvcFunAppDelegate.m
//  KvcFun
//
//  Created by Adam Preble on 9/9/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "KvcFunAppDelegate.h"

@implementation KvcFunAppDelegate

@synthesize window = _window;
@synthesize fido;

- (id)init {
	self = [super init];
	if (self) {
		[self setValue:[NSNumber numberWithInt:5]
				forKey:@"fido"];
		NSNumber *n = [self valueForKey:@"fido"];
		NSLog(@"fido = %@", n);
	}
	return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

//- (int)fido {
//	NSLog(@"-fido is returning %d", fido);
//	return fido;
//}
//
//- (void)setFido:(int)x
//{
//    NSLog(@"-setFido: is called with %d", x);
//	fido = x;
//}

- (IBAction)incrementFido:(id)sender
{
	[self willChangeValueForKey:@"fido"];
	fido++;
	[self didChangeValueForKey:@"fido"];
	NSLog(@"fido is now %d", fido);
}

@end
