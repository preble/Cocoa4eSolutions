//
//  RMDocument.h
//  RaiseMan
//
//  Created by Adam Preble on 9/19/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RMDocument : NSDocument {
	NSMutableArray *employees;
}
- (void)setEmployees:(NSMutableArray *)a;

@end
