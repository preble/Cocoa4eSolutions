//
//  MyDocument.h
//  Departments
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ManagingViewController;

@interface MyDocument : NSPersistentDocument {
	IBOutlet NSBox *box;
	IBOutlet NSPopUpButton *popUp;
	NSMutableArray *viewControllers;
}

- (IBAction)changeViewController:(id)sender;

- (void)displayViewController:(ManagingViewController *)vc;

@end
