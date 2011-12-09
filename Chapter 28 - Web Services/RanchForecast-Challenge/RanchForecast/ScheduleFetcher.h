//
//  ScheduleFetcher.h
//  RanchForecast
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleFetcher : NSObject <NSXMLParserDelegate> {
	NSMutableArray *classes;
	NSMutableString *currentString;
	NSMutableDictionary *currentFields;
	NSDateFormatter *dateFormatter;
}
// Returns an NSArray of ScheduledClass objects if successful.
// Returns nil on failure.
- (NSArray *)fetchClassesWithError:(NSError **)outError;

@end
