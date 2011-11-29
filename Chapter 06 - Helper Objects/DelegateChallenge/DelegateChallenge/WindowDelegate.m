//
//  WindowDelegate.m
//  DelegateChallenge
//
//  Created by Adam Preble on 11/29/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "WindowDelegate.h"

@implementation WindowDelegate

- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize
{
	NSSize newSize = frameSize;
	newSize.height = newSize.width * 2;
	return newSize;
}

@end
