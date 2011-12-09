//
//  PeopleView.m
//  RaiseMan
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "PeopleView.h"
#import "Person.h"

@implementation PeopleView

- (id)initWithPeople:(NSArray *)persons
{
    // Call the superclass's designated initializer with some
    // dummy frame
    self = [super initWithFrame:NSMakeRect(0, 0, 700, 700)];
    if (self) {
        people = [persons copy];
        // The attributes of the text to be printed
        attributes = [[NSMutableDictionary alloc] init];
        NSFont *font = [NSFont fontWithName:@"Monaco" size:12.0];
        lineHeight = [font capHeight] * 1.7;
        [attributes setObject:font
					   forKey:NSFontAttributeName];
	}
    return self;
}

#pragma mark Pagination

- (BOOL)knowsPageRange:(NSRange *)range
{
	NSPrintOperation *po = [NSPrintOperation currentOperation];
	NSPrintInfo *printInfo = [po printInfo];
	// Where can I draw?
	pageRect = [printInfo imageablePageBounds];
	NSRect newFrame;
	newFrame.origin = NSZeroPoint;
	newFrame.size = [printInfo paperSize];
	[self setFrame:newFrame];
	// How many lines per page?
	linesPerPage = pageRect.size.height / lineHeight;
	// Pages are 1-based
	range->location = 1;
	// How many pages will it take?
	range->length = [people count] / linesPerPage;
	if ([people count] % linesPerPage) {
		range->length = range->length + 1;
	}
	return YES;
}
- (NSRect)rectForPage:(NSInteger)i
{
	// Note the current page
	currentPage = i - 1;
	// Return the same page rect everytime
	return pageRect;
}

#pragma mark Drawing
// The origin of the view is at the upper-left corner
- (BOOL)isFlipped
{
	return YES;
}
- (void)drawRect:(NSRect)r
{
	NSRect nameRect;
	NSRect raiseRect;
	raiseRect.size.height = nameRect.size.height = lineHeight;
	nameRect.origin.x = pageRect.origin.x;
	nameRect.size.width = 200.0;
	raiseRect.origin.x = NSMaxX(nameRect);
	raiseRect.size.width = 100.0;
	NSInteger i;
	for (i=0; i<linesPerPage; i++)
	{
		NSInteger index = (currentPage * linesPerPage) + i;
        if (index >= [people count]) {
			break; }
        Person *p = [people objectAtIndex:index];
        // Draw index and name
        nameRect.origin.y = pageRect.origin.y + (i * lineHeight);
        NSString *nameString = [NSString stringWithFormat:@"%2d %@",
								index, [p personName]];
        [nameString drawInRect:nameRect withAttributes:attributes];
        raiseRect.origin.y = nameRect.origin.y;
        NSString *raiseString=[NSString stringWithFormat:@"%4.1f%%",
							   [p expectedRaise]];
        [raiseString drawInRect:raiseRect withAttributes:attributes];
	}
	
	// To draw the page number we will need a couple things:
	// - A rectangle to draw it in. We'll use NSDivideRect() for that.
	// - Attributes so the text will be drawn centered. NSParagraphStyle helps with this.
	NSRect pageNumberRect, remainder;
	NSDivideRect(pageRect, &pageNumberRect, &remainder, lineHeight, NSMaxYEdge);
	NSMutableDictionary *pageNumberAttributes = [attributes mutableCopy];
	NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
	[paraStyle setAlignment:NSCenterTextAlignment];
	[pageNumberAttributes setObject:paraStyle forKey:NSParagraphStyleAttributeName];
	NSString *pageString = [NSString stringWithFormat:@"Page %d", currentPage + 1];
	[pageString drawInRect:pageNumberRect withAttributes:pageNumberAttributes];
}

@end
