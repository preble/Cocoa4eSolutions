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
	NSImage *image;
	float opacity;
	NSPoint downPoint;
	NSPoint currentPoint;
	NSTimer *autoscrollTimer;
}
@property (assign) float opacity;
@property (strong) NSImage *image;

- (NSPoint)randomPoint;
- (NSRect)currentRect;

@end
