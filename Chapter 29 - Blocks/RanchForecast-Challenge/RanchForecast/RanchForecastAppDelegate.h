//
//  RanchForecastAppDelegate.h
//  RanchForecast
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ScheduleFetcher.h"

@interface RanchForecastAppDelegate : NSObject <NSApplicationDelegate, ScheduleFetcherDelegate> {
	IBOutlet NSTableView *tableView;
	NSArray *classes;
}

@property (assign) IBOutlet NSWindow *window;

@end
