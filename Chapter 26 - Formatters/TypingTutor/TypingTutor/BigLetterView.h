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
	NSMutableDictionary *attributes;
	NSEvent *mouseDownEvent;
	BOOL highlighted;
}
@property (strong) NSColor *bgColor;
@property (copy) NSString *string;

- (void)prepareAttributes;

- (IBAction)savePDF:(id)sender;

@end
