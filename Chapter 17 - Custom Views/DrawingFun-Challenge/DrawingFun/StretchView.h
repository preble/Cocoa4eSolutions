//
//  StretchView.h
//  DrawingFun
//
//  Created by Adam Preble on 9/21/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StretchView : NSView {
	NSBezierPath *path;
}
- (NSPoint)randomPoint;

@end
