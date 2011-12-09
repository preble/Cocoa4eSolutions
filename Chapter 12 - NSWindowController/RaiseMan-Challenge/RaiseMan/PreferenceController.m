//
//  PreferenceController.m
//  RaiseMan
//
//  Created by Adam Preble on 9/19/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "PreferenceController.h"

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
    NSLog(@"Nib file is loaded");
}
- (IBAction)changeBackgroundColor:(id)sender
{
    NSColor *color = [colorWell color];
    NSLog(@"Color changed: %@", color);
}
- (IBAction)changeNewEmptyDoc:(id)sender
{
    NSInteger state = [checkbox state];
    NSLog(@"Checkbox changed %ld", state);
}

@end
