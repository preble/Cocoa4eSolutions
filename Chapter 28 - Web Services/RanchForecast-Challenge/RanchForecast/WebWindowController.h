//
//  WebWindowController.h
//  RanchForecast
//
//  Created by Adam Preble on 12/9/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WebView;

@interface WebWindowController : NSWindowController {
	IBOutlet WebView *webView;
	IBOutlet NSProgressIndicator *progress;
}

- (IBAction)close:(id)sender;

- (void)openURL:(NSURL *)url;

@end
