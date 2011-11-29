//
//  ScatteredAppDelegate.h
//  Scattered
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface ScatteredAppDelegate : NSObject <NSApplicationDelegate> {
	IBOutlet NSView *view;
	CATextLayer *textLayer;
	
	NSOperationQueue *processingQueue;
}

@property (assign) IBOutlet NSWindow *window;

@end
