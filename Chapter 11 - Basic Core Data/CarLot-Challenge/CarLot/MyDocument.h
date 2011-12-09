//
//  MyDocument.h
//  CarLot
//
//  Created by Adam Preble on 9/19/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyDocument : NSPersistentDocument {
	IBOutlet NSTableView *tableView;
	IBOutlet NSArrayController *carsController;
}

@end
