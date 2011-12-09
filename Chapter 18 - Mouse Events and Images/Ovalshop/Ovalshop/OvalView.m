//
//  OvalView.m
//  Ovalshop
//
//  Created by Adam Preble on 12/8/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "OvalView.h"
#import "Document.h"

@implementation OvalView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (Document *)document
{
	return (Document *)[[[self window] windowController] document];
}

- (void)drawRect:(NSRect)dirtyRect
{
	// Draw a black background:
	[[NSColor blackColor] setFill];
	NSRectFill([self bounds]);
	
	// Draw each of the existing ovals in orange:
	[[NSColor orangeColor] setStroke];
	
	for (NSValue *ovalValue in [[self document] ovals])
	{
		NSRect ovalRect = [ovalValue rectValue];
		[[NSBezierPath bezierPathWithOvalInRect:ovalRect] stroke];
	}
	
	// If we are currently drawing a new oval, draw it in green with a gray bounding box:
	if (!NSEqualRects(workingOval, NSZeroRect))
	{
		[[NSColor grayColor] setStroke];
		[[NSBezierPath bezierPathWithRect:workingOval] stroke];
		
		[[NSColor greenColor] setStroke];
		[[NSBezierPath bezierPathWithOvalInRect:workingOval] stroke];
	}
}

- (void)mouseDown:(NSEvent *)theEvent
{
	NSPoint pointInView = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	// Why do we offset by 0.5? Because lines drawn exactly on the .0 will end up spread over two pixels.
	workingOval = NSMakeRect(pointInView.x + 0.5, pointInView.y + 0.5, 0, 0);
	[self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
	NSPoint pointInView = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	workingOval.size.width = pointInView.x - (workingOval.origin.x - 0.5);
	workingOval.size.height = pointInView.y - (workingOval.origin.y - 0.5);
	[self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent
{
	[[self document] addOvalWithRect:workingOval];
	workingOval = NSZeroRect; // zero rect indicates we are not presently drawing
	[self setNeedsDisplay:YES];
}

@end
