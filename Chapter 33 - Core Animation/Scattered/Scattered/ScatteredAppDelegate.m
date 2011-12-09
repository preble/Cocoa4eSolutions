//
//  ScatteredAppDelegate.m
//  Scattered
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "ScatteredAppDelegate.h"

@interface ScatteredAppDelegate ()
- (void)addImagesFromFolderURL:(NSURL *)url;
- (NSImage *)thumbImageFromImage:(NSImage *)image;
- (void)presentImage:(NSImage *)image;
- (void)setText:(NSString *)text;
@end

@implementation ScatteredAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	srandom((unsigned)time(NULL));
	
	// Set view to be layer-hosting:
	view.layer = [CALayer layer];
	[view setWantsLayer:YES];
	
	CALayer *textContainer = [CALayer layer];
	textContainer.anchorPoint = CGPointZero;
	textContainer.position = CGPointMake(10, 10);
	textContainer.zPosition = 100;
	textContainer.backgroundColor = CGColorGetConstantColor(kCGColorBlack);
	textContainer.borderColor = CGColorGetConstantColor(kCGColorWhite); textContainer.borderWidth = 2;
	textContainer.cornerRadius = 15;
	textContainer.shadowOpacity = 0.5f;
	[view.layer addSublayer:textContainer];
	
	textLayer = [CATextLayer layer];
	textLayer.anchorPoint = CGPointZero;
	textLayer.position = CGPointMake(10, 6);
	textLayer.zPosition = 100;
	textLayer.fontSize = 24;
	textLayer.foregroundColor = CGColorGetConstantColor(kCGColorWhite);
	[textContainer addSublayer:textLayer];
	
	// Rely on setText: to set the above layers' bounds: [self setText:@"Loading..."];
	[self addImagesFromFolderURL:[NSURL fileURLWithPath:@"/Library/Desktop Pictures"]];

}

- (void)setText:(NSString *)text
{
	NSFont *font = [NSFont systemFontOfSize:textLayer.fontSize];
	NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
	NSSize size = [text sizeWithAttributes:attrs];
	
	// Ensure that the size is in whole numbers:
	size.width = ceilf(size.width);
	size.height = ceilf(size.height);
	textLayer.bounds = CGRectMake(0, 0, size.width, size.height);
	textLayer.superlayer.bounds = CGRectMake(0, 0, size.width + 16, size.height + 20);
	textLayer.string = text;
}

- (NSImage *)thumbImageFromImage:(NSImage *)image
{
	const CGFloat targetHeight = 200.0f;
	NSSize imageSize = [image size];
	NSSize smallerSize = NSMakeSize(targetHeight * imageSize.width /
									imageSize.height, targetHeight);
	NSImage *smallerImage = [[NSImage alloc] initWithSize:smallerSize];
	[smallerImage lockFocus];
	[image drawInRect:NSMakeRect(0, 0, smallerSize.width,
								 smallerSize.height)
			 fromRect:NSZeroRect
			operation:NSCompositeCopy fraction:1.0];
	[smallerImage unlockFocus];
	
	return smallerImage;
}

- (void)addImagesFromFolderURL:(NSURL *)folderURL
{
	NSTimeInterval t0 = [NSDate timeIntervalSinceReferenceDate];
	NSFileManager *fileManager = [NSFileManager new];
	NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtURL:folderURL
									   includingPropertiesForKeys:nil
														  options:NSDirectoryEnumerationSkipsHiddenFiles
													 errorHandler:nil];
	int allowedFiles = 10;
	for (NSURL *url in dirEnum) {
		// Skip directories:
		NSNumber *isDirectory = nil;
		[url getResourceValue:&isDirectory
					   forKey:NSURLIsDirectoryKey error:nil];
		
		if ([isDirectory boolValue])
			continue;
		
		NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];
		if (!image)
			return;
		
		allowedFiles--;
		if (allowedFiles < 0)
			break;
		NSImage *thumbImage = [self thumbImageFromImage:image];
		[self presentImage:thumbImage];
		[self setText:[NSString stringWithFormat:@"%0.1fs",
					   [NSDate timeIntervalSinceReferenceDate] - t0]];
	}
}

- (void)presentImage:(NSImage *)image
{
	CGRect superlayerBounds = view.layer.bounds;
	NSPoint center = NSMakePoint(CGRectGetMidX(superlayerBounds), CGRectGetMidY(superlayerBounds));
	NSRect imageBounds = NSMakeRect(0, 0, image.size.width, image.size.height);
	
	CGPoint randomPoint = CGPointMake(CGRectGetMaxX(superlayerBounds) * (double)random() / (double)RAND_MAX, 
									  CGRectGetMaxY(superlayerBounds) * (double)random() / (double)RAND_MAX);
	
	CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CABasicAnimation *posAnim = [CABasicAnimation animation]; 
	posAnim.fromValue = [NSValue valueWithPoint:center];
	posAnim.duration = 1.5;
	posAnim.timingFunction = tf;
	
	CABasicAnimation *bdsAnim = [CABasicAnimation animation];
	bdsAnim.fromValue = [NSValue valueWithRect:NSZeroRect];
	bdsAnim.duration = 1.5;
	bdsAnim.timingFunction = tf;
	
	CALayer *layer = [CALayer layer];
	layer.contents = image;
	layer.actions = [NSDictionary dictionaryWithObjectsAndKeys:
					 posAnim, @"position", bdsAnim, @"bounds", nil];
	[CATransaction begin];
	[view.layer addSublayer:layer];
	layer.position = randomPoint;
	layer.bounds = NSRectToCGRect(imageBounds);
	[CATransaction commit];
}

@end
