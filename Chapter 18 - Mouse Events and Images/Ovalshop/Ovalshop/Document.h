//
//  Document.h
//  Ovalshop
//
//  Created by Adam Preble on 12/8/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class OvalView;

@interface Document : NSDocument

@property (weak) IBOutlet OvalView *ovalView;

// ovals is an array of NSValues containing NSRects.
@property (strong) NSMutableArray *ovals;

- (void)addOvalWithRect:(NSRect)rect;
- (void)removeLastOval;

@end
