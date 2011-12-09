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

@implementation PreferenceController

- (id)init
{
    self = [super initWithWindowNibName:@"Preferences"];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)reloadFromPreferences
{
	[colorWell setColor:[PreferenceController preferenceTableBgColor]];
	[checkbox setState:[PreferenceController preferenceEmptyDoc]];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
	[self reloadFromPreferences];
}
- (IBAction)changeBackgroundColor:(id)sender
{
    NSColor *color = [colorWell color];
	[PreferenceController setPreferenceTableBgColor:color];
}
- (IBAction)changeNewEmptyDoc:(id)sender
{
    NSInteger state = [checkbox state];
    [PreferenceController setPreferenceEmptyDoc:state];
}

- (IBAction)resetPreferences:(id)sender
{
	NSArray *allDefaultKeys = [NSArray arrayWithObjects:BNRTableBgColorKey, BNREmptyDocKey, nil];
	for (NSString *key in allDefaultKeys)
	{
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
	}
	[self reloadFromPreferences];
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
