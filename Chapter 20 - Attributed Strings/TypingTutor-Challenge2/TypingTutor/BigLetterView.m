//
//  BigLetterView.m
//  TypingTutor
//
//  Created by Adam Preble on 9/21/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "BigLetterView.h"

@implementation BigLetterView

@synthesize bold, italic;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initializing view");
		[self prepareAttributes];
        bgColor = [NSColor yellowColor];
        string = @" ";
    }
    
    return self;
}

- (void)drawStringCenteredIn:(NSRect)r
{
	NSSize strSize = [string sizeWithAttributes:attributes];
	NSPoint strOrigin;
	strOrigin.x = r.origin.x + (r.size.width - strSize.width)/2;
	strOrigin.y = r.origin.y + (r.size.height - strSize.height)/2;
	[string drawAtPoint:strOrigin withAttributes:attributes];
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSRect bounds = [self bounds];
	[bgColor set];
	[NSBezierPath fillRect:bounds];
	
	[self drawStringCenteredIn:bounds];
	
	// Am I the window's first responder?
	if (([[self window] firstResponder] == self) &&
		[NSGraphicsContext currentContextDrawingToScreen])
	{
		[NSGraphicsContext saveGraphicsState];
		NSSetFocusRingStyle(NSFocusRingOnly);
		[NSBezierPath fillRect:bounds];
		[NSGraphicsContext restoreGraphicsState];
	}
}
- (BOOL)isOpaque
{
	return YES;
}

- (BOOL)acceptsFirstResponder
{
	NSLog(@"Accepting");
	return YES;
}
- (BOOL)resignFirstResponder
{
	NSLog(@"Resigning");
	[self setKeyboardFocusRingNeedsDisplayInRect:[self bounds]];
	return YES;
}
- (BOOL)becomeFirstResponder
{
    NSLog(@"Becoming");
    [self setNeedsDisplay:YES];
    return YES;
}


- (void)keyDown:(NSEvent *)event
{
    [self interpretKeyEvents:[NSArray arrayWithObject:event]];
}

- (void)insertText:(NSString *)input
{
    // Set string to be what the user typed
    [self setString:input];
}
- (void)insertTab:(id)sender
{
    [[self window] selectKeyViewFollowingView:self];
}
// Be careful with capitalization here “backtab” is considered
// one word.
- (void)insertBacktab:(id)sender
{
    [[self window] selectKeyViewPrecedingView:self];
}
- (void)deleteBackward:(id)sender
{
    [self setString:@" "];
}


- (IBAction)savePDF:(id)sender
{
	__block NSSavePanel *panel = [NSSavePanel savePanel];
	[panel setAllowedFileTypes:[NSArray arrayWithObject:@"pdf"]];
	[panel beginSheetModalForWindow:[self window]
				  completionHandler:^ (NSInteger result) {
					  if (result == NSOKButton)
					  {
						  NSRect r = [self bounds];
						  NSData *data = [self dataWithPDFInsideRect:r];
						  NSError *error;
						  BOOL successful = [data writeToURL:[panel URL]
													 options:0
													   error:&error];
						  if (!successful) {
							  NSAlert *a = [NSAlert alertWithError:error];
							  [a runModal];
						  } }
					  panel = nil; // avoid strong ref cycle
				  }];
}

- (IBAction)toggleBold:(NSButton *)sender
{
	[self setBold:[sender state] == NSOnState];
}

- (IBAction)toggleItalic:(NSButton *)sender
{
	[self setItalic:[sender state] == NSOnState];
}


#pragma mark Accessors

- (void)setBgColor:(NSColor *)c
{
	bgColor = c;
    [self setNeedsDisplay:YES];
}
- (NSColor *)bgColor
{
    return bgColor;
}
- (void)setString:(NSString *)c
{
	string = c;
	NSLog(@"The string is now %@", string);
	[self setNeedsDisplay:YES];
}
- (NSString *)string
{
	return string;
}

- (void)prepareAttributes
{
	attributes = [NSMutableDictionary dictionary];
	
	NSFont *font = [NSFont userFontOfSize:75];
	NSFontManager *fontManager = [NSFontManager sharedFontManager];
	if ([self italic])
		font = [fontManager convertFont:font toHaveTrait:NSItalicFontMask];
	if ([self bold])
		font = [fontManager convertFont:font toHaveTrait:NSBoldFontMask];
	
	[attributes setObject:font
				   forKey:NSFontAttributeName];
	[attributes setObject:[NSColor redColor]
				   forKey:NSForegroundColorAttributeName];
	
	NSShadow *shadow = [[NSShadow alloc] init];
	[shadow setShadowOffset:NSMakeSize(0, -2)];
	[shadow setShadowBlurRadius:3];
	[shadow setShadowColor:[NSColor blackColor]];
	[attributes setObject:shadow forKey:NSShadowAttributeName];
}

- (void)setBold:(BOOL)bold_
{
	bold = bold_;
	[self prepareAttributes];
	[self setNeedsDisplay:YES];
}

- (void)setItalic:(BOOL)italic_
{
	italic = italic_;
	[self prepareAttributes];
	[self setNeedsDisplay:YES];
}

@end
