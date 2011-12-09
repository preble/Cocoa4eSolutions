//
//  PreferenceController.m
//  RaiseMan
//
//  Created by Adam Preble on 9/19/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "PreferenceController.h"

NSString * const BNRTableBgColorKey = @"BNRTableBackgroundColor";
NSString * const BNREmptyDocKey = @"BNREmptyDocumentFlag";

NSString * const BNRColorChangedNotification = @"BNRColorChanged";

@implementation PreferenceController

- (id)init
{
    self = [super initWithWindowNibName:@"Preferences"];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
	[colorWell setColor:
	 [PreferenceController preferenceTableBgColor]];
	[checkbox setState:
	 [PreferenceController preferenceEmptyDoc]];
}

- (BOOL)windowShouldClose:(id)sender
{
	[[NSColorPanel sharedColorPanel] orderOut:nil];
	return YES;
}

- (IBAction)changeBackgroundColor:(id)sender
{
    NSColor *color = [colorWell color];
	[PreferenceController setPreferenceTableBgColor:color];
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	NSLog(@"Sending notification");
	NSDictionary *d = [NSDictionary dictionaryWithObject:color
												  forKey:@"color"];
	[nc postNotificationName:BNRColorChangedNotification
					  object:self
					userInfo:d];
}
- (IBAction)changeNewEmptyDoc:(id)sender
{
    NSInteger state = [checkbox state];
    [PreferenceController setPreferenceEmptyDoc:state];
}


+ (NSColor *)preferenceTableBgColor
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSData *colorAsData = [defaults objectForKey:BNRTableBgColorKey];
	return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}
+ (void)setPreferenceTableBgColor:(NSColor *)color
{
	NSData *colorAsData =
	[NSKeyedArchiver archivedDataWithRootObject:color];
	[[NSUserDefaults standardUserDefaults] setObject:colorAsData
											  forKey:BNRTableBgColorKey];
}
+ (BOOL)preferenceEmptyDoc
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:BNREmptyDocKey];
}
+ (void)setPreferenceEmptyDoc:(BOOL)emptyDoc
{
	[[NSUserDefaults standardUserDefaults] setBool:emptyDoc
											forKey:BNREmptyDocKey];
}

@end
