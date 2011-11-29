//
//  TodoController.h
//  TodoChallenge
//
//  Created by Adam Preble on 11/29/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoController : NSObject <NSTableViewDataSource>

@property (nonatomic, copy) NSMutableArray *items;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *itemInputField;
@property (nonatomic, unsafe_unretained) IBOutlet NSTableView *tableView;

- (IBAction)add:(id)sender;

@end
