//
//  LetterCountAppDelegate.h
//  LetterCountChallenge
//
//  Created by Adam Preble on 9/9/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LetterCountAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *outputTextField;
@property (weak) IBOutlet NSTextField *inputTextField;

- (IBAction)count:(id)sender;
@end
