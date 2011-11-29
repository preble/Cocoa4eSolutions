//
//  KvcFunAppDelegate.h
//  KvcFun
//
//  Created by Adam Preble on 9/9/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KvcFunAppDelegate : NSObject <NSApplicationDelegate> {
	int fido;
}

@property (assign) IBOutlet NSWindow *window;
@property (readwrite, assign) int fido;

//- (int)fido;
//- (void)setFido:(int)x;

- (IBAction)incrementFido:(id)sender;

@end
