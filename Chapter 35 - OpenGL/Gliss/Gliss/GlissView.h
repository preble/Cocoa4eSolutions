//
//  GlissView.h
//  Gliss
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface GlissView : NSOpenGLView {
	IBOutlet NSMatrix *sliderMatrix;
	float lightX, theta, radius;
    int displayList;
}

- (IBAction)changeParameter:(id)sender;

@end
