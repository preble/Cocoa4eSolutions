//
//  TutorController.h
//  TypingTutor
//
//  Created by Adam Preble on 9/21/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BigLetterView;

@interface TutorController : NSObject {
	// Outlets
	IBOutlet BigLetterView *inLetterView;
	IBOutlet BigLetterView *outLetterView;
	IBOutlet NSWindow *speedSheet;
	// Data
	NSArray *letters;
	int lastIndex;
	// Time
	NSTimeInterval startTime;
	NSTimeInterval elapsedTime;
	NSTimeInterval timeLimit;
	NSTimer *timer;
}
- (IBAction)stopGo:(id)sender;
- (IBAction)showSpeedSheet:(id)sender;
- (IBAction)endSpeedSheet:(id)sender;

- (void)updateElapsedTime;
- (void)resetElapsedTime;
- (void)showAnotherLetter;

@end
