//
//  DrawingFunAppDelegate.m
//  DrawingFun
//
//  Created by Adam Preble on 9/21/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "DrawingFunAppDelegate.h"
#import "StretchView.h"

@implementation DrawingFunAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

- (IBAction)showOpenPanel:(id)sender
{
    __block NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setAllowedFileTypes:[NSImage imageFileTypes]];
    [panel beginSheetModalForWindow:[stretchView window]
                  completionHandler:^ (NSInteger result) {
					  if (result == NSOKButton) {
						  NSImage *image = [[NSImage alloc]
											initWithContentsOfURL:[panel URL]];
						  [stretchView setImage:image];
					  }
					  panel = nil; // prevent strong ref cycle
				  }];
}
@end
