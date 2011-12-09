//
//  RanchForecastAppDelegate.h
//  RanchForecast
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WebWindowController;

@interface RanchForecastAppDelegate : NSObject <NSApplicationDelegate> {
	IBOutlet NSTableView *tableView;
	NSArray *classes;
	WebWindowController *webWindowController;
}

@property (assign) IBOutlet NSWindow *window;

@end
