//
//  MyDocument.h
//  ZIPspector
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument {
	IBOutlet NSTableView *tableView;
    NSArray *filenames;
}

@end
