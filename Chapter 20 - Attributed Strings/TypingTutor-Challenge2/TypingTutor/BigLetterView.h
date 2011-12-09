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
	BOOL italic;
	BOOL bold;
}
@property (strong) NSColor *bgColor;
@property (copy) NSString *string;
@property (assign, nonatomic) BOOL italic;
@property (assign, nonatomic) BOOL bold;

- (void)prepareAttributes;

- (IBAction)savePDF:(id)sender;
- (IBAction)toggleBold:(id)sender;
- (IBAction)toggleItalic:(id)sender;

@end
