//
//  DrawingFunAppDelegate.h
//  DrawingFun
//
//  Created by Adam Preble on 9/21/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class StretchView;

@interface DrawingFunAppDelegate : NSObject <NSApplicationDelegate> {
	IBOutlet StretchView *stretchView;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)showOpenPanel:(id)sender;

@end
