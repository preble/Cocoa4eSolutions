//
//  iPingAppDelegate.h
//  iPing
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface iPingAppDelegate : NSObject <NSApplicationDelegate> {
	IBOutlet NSTextView *outputView;
	IBOutlet NSTextField *hostField;
    IBOutlet NSButton *startButton;
    NSTask *task;
    NSPipe *pipe;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)startStopPing:(id)sender;

@end
