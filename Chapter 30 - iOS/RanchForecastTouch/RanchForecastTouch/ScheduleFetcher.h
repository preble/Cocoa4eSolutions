//
//  ScheduleFetcher.h
//  RanchForecast
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ScheduleFetcherResultBlock)(NSArray *classes,
										   NSError *error);

@interface ScheduleFetcher : NSObject <NSXMLParserDelegate> {
	NSMutableArray *classes;
	NSMutableString *currentString;
	NSMutableDictionary *currentFields;
	NSDateFormatter *dateFormatter;
	
	ScheduleFetcherResultBlock resultBlock;
	NSMutableData *responseData;
	NSURLConnection *connection;
}
- (void)fetchClassesWithBlock:(ScheduleFetcherResultBlock)theBlock;

@end
