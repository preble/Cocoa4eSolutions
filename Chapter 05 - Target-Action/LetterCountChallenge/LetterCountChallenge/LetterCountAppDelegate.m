//
//  LetterCountAppDelegate.m
//  LetterCountChallenge
//
//  Created by Adam Preble on 9/9/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "LetterCountAppDelegate.h"

@implementation LetterCountAppDelegate

@synthesize window = _window;
@synthesize outputTextField = _outputTextField;
@synthesize inputTextField = _inputTextField;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

- (void)awakeFromNib
{
	[_outputTextField setStringValue:@""];
}

- (IBAction)count:(id)sender
{
	NSString *string = [_inputTextField stringValue];
	NSString *text = [NSString stringWithFormat:@"'%@' has %d characters.", string, [string length]];
	[_outputTextField setStringValue:text];
}
@end
