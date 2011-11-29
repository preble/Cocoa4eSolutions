//
//  BigLetterView.h
//  TypingTutor
//
//  Created by Adam Preble on 9/21/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BigLetterView : NSView {
	NSColor *bgColor;
	NSString *string;
}
@property (strong) NSColor *bgColor;
@property (copy) NSString *string;

@end
