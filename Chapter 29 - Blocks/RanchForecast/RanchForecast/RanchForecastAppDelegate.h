//
//  RanchForecastAppDelegate.h
//  RanchForecast
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RanchForecastAppDelegate : NSObject <NSApplicationDelegate> {
	IBOutlet NSTableView *tableView;
	NSArray *classes;
}

@property (assign) IBOutlet NSWindow *window;

@end
