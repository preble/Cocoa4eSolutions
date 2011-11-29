//
//  ColorFormatter.m
//  TypingTutor
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "ColorFormatter.h"

@interface ColorFormatter ()
- (NSString *)firstColorKeyForPartialString:(NSString *)string;
@end

@implementation ColorFormatter

- (id)init {
    self = [super init];
    if (self) {
        colorList = [NSColorList colorListNamed:@"Apple"];
    }
    return self;
}
- (NSString *)firstColorKeyForPartialString:(NSString *)string
{
    // Is the key zero-length?
    if ([string length] == 0) {
		return nil; }
    // Loop through the color list
    for (NSString *key in [colorList allKeys]) {
        NSRange whereFound = [key rangeOfString:string
										options:NSCaseInsensitiveSearch];
        // Does the string match the beginning of the color name?
        if ((whereFound.location == 0) && (whereFound.length > 0)) {
			return key;
		}
    }
    // If no match is found, return nil
    return nil;
}

- (NSString *)stringForObjectValue:(id)obj
{
	// Not a color?
	if (![obj isKindOfClass:[NSColor class]]) {
		return nil; }
	// Convert to an RGB Color Space
	NSColor *color;
	color = [obj colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	// Get components as floats between 0 and 1
	CGFloat red, green, blue;
	[color getRed:&red
			green:&green
			 blue:&blue
			alpha:NULL];
	// Initialize the distance to something large
	float minDistance = 3.0;
	NSString *closestKey = nil;
	// Find the closest color
	for (NSString *key in [colorList allKeys]) {
		NSColor *c = [colorList colorWithKey:key];
		CGFloat r, g, b;
		[c getRed:&r
			green:&g
			 blue:&b
			alpha:NULL];
		// How far apart are 'color' and 'c'?
		float dist;
		dist = pow(red - r, 2) + pow(green -g, 2) + pow(blue - b, 2);
		// Is this the closest yet?
		if (dist < minDistance) {
			minDistance = dist;
			closestKey = key;
		}
	}
	// Return the name of the closest color
	return closestKey;
}
- (BOOL)getObjectValue:(id *)obj
			 forString:(NSString *)string
	  errorDescription:(NSString **)errorString
{
	// Look up the color for 'string'
	NSString *matchingKey = [self firstColorKeyForPartialString:string];
	if (matchingKey) {
		*obj = [colorList colorWithKey:matchingKey];
		return YES;
	} else {
		// Occasionally, 'errorString' is NULL
		if (errorString != NULL) {
			*errorString = [NSString stringWithFormat:
							@" is not a color", string];
		}
		return NO;
	}
}

//- (BOOL)isPartialStringValid:(NSString *)partial
//			newEditingString:(NSString **)newString
//			errorDescription:(NSString **)error
//{
//	// Zero-length strings are OK
//	if ([partial length] == 0){
//		return YES; }
//	NSString *match = [self firstColorKeyForPartialString:partial];
//	if (match) {
//		return YES;
//	} else {
//		if (error) {
//			*error = @"No such color";
//		}
//		return NO;
//	}
//}

- (BOOL)isPartialStringValid:(NSString **)partial
       proposedSelectedRange:(NSRange *)selPtr
              originalString:(NSString *)origString
       originalSelectedRange:(NSRange)origSel
            errorDescription:(NSString **)error
{
    // Zero-length strings are fine
    if ([*partial length] == 0) {
		return YES;
	}
    NSString *match = [self firstColorKeyForPartialString:*partial];
    // No color match?
    if (!match) {
		return NO;
	}
    // If this would not move the beginning of the selection, it
    // is a delete
    if (origSel.location == selPtr->location) {
		return YES;
	}
    // If the partial string is shorter than the
    // match, provide the match and set the selection
    if ([match length] != [*partial length]) {
        selPtr->location = [*partial length];
        selPtr->length = [match length] - selPtr->location;
        *partial = match;
		return NO;
	}
	return YES;
}

- (NSAttributedString *)attributedStringForObjectValue:(id)anObj
								 withDefaultAttributes:(NSDictionary *)attributes
{
	NSString *match = [self stringForObjectValue:anObj];
	if (!match) {
		return nil;
	}
	NSMutableDictionary *attDict = [attributes mutableCopy];
	[attDict setObject:anObj
				forKey:NSForegroundColorAttributeName];
	NSAttributedString *atString
	= [[NSAttributedString alloc] initWithString:match
									  attributes:attDict];
	return atString;
}

@end
