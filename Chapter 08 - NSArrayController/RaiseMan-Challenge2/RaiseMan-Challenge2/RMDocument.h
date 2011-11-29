//
//  RMDocument.h
//  RaiseMan-Challenge2
//
//  Created by Adam Preble on 11/29/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RMDocument : NSDocument <NSTableViewDataSource> {
	NSMutableArray *employees;
	IBOutlet NSTableView *tableView;
}
- (IBAction)createEmployee:(id)sender;
- (IBAction)deleteSelectedEmployee:(id)sender;
@end
