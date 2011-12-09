//
//  ScheduleFetcher.h
//  RanchForecast
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScheduleFetcherDelegate;

@interface ScheduleFetcher : NSObject <NSXMLParserDelegate> {
	NSMutableArray *classes;
	NSMutableString *currentString;
	NSMutableDictionary *currentFields;
	NSDateFormatter *dateFormatter;
	
	__weak id<ScheduleFetcherDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *connection;
}
@property (nonatomic, weak) id<ScheduleFetcherDelegate> delegate;

- (void)fetchClasses;

@end



@protocol ScheduleFetcherDelegate <NSObject>

@optional // make them optional just for fun, so we can demonstrate respondsToSelector:.

- (void)scheduleFetcher:(ScheduleFetcher *)sf fetchedClasses:(NSArray *)classes;
- (void)scheduleFetcher:(ScheduleFetcher *)sf didFailWithError:(NSError *)error;

@end