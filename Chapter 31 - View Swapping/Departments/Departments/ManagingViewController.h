//
//  ManagingViewController.h
//  Departments
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ManagingViewController : NSViewController {
	NSManagedObjectContext *managedObjectContext;
}
@property (strong) NSManagedObjectContext *managedObjectContext;

@end
