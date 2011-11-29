//
//  ScheduleFetcher.m
//  RanchForecast
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "ScheduleFetcher.h"
#import "ScheduledClass.h"

@implementation ScheduleFetcher

- (id)init {
	self = [super init];
	if (self) {
		classes = [[NSMutableArray alloc] init];
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzzz"];
	}
	return self;
}

- (void)fetchClassesWithBlock:(ScheduleFetcherResultBlock)theBlock {
	// Copy the block to ensure that it is not kept on the stack:
	resultBlock = [theBlock copy];
	
	NSURL *xmlURL = [NSURL URLWithString:
					 @"http://bignerdranch.com/xml/schedule"];
	NSURLRequest *req = [NSURLRequest requestWithURL:xmlURL
										 cachePolicy:NSURLRequestReturnCacheDataElseLoad
									 timeoutInterval:30];
	connection = [[NSURLConnection alloc] initWithRequest:req
												 delegate:self];
	if (connection)
	{
		responseData = [[NSMutableData alloc] init];
	}
}

- (void)cleanup
{
    responseData = nil;
    connection = nil;
    resultBlock = nil;
}



- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqual:@"class"])
    {
        currentFields = [[NSMutableDictionary alloc] init];
    }
    else if ([elementName isEqual:@"offering"])
    {
		[currentFields setObject:[attributeDict objectForKey:@"href"]
						  forKey:@"href"];
	}
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	if ([elementName isEqual:@"class"])
    {
		ScheduledClass *currentClass = [[ScheduledClass alloc] init];
        [currentClass setName:[currentFields
							   objectForKey:@"offering"]];
        [currentClass setLocation:[currentFields
								   objectForKey:@"location"]];
        [currentClass setHref:[currentFields
							   objectForKey:@"href"]];
        NSString *beginString = [currentFields objectForKey:@"begin"];
        NSDate *beginDate = [dateFormatter
							 dateFromString:beginString];
        [currentClass setBegin:beginDate];
        [classes addObject:currentClass];
        currentClass = nil;
        currentFields = nil;
    }
    else if (currentFields && currentString)
    {
        NSString *trimmed;
        trimmed = [currentString stringByTrimmingCharactersInSet:
                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [currentFields setObject:trimmed forKey:elementName];
	}
    currentString = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!currentString){
        currentString = [[NSMutableString alloc] init];
	}
	[currentString appendString:string];
}

#pragma mark -
#pragma mark NSURLConnection Delegate
- (void)connection:(NSURLConnection *)theConnection
    didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    [classes removeAllObjects];
    NSXMLParser *parser = [[NSXMLParser alloc]
						   initWithData:responseData];
    [parser setDelegate:self];
	BOOL success = [parser parse];
	if (!success)
	{
		resultBlock(nil, [parser parserError]);
	}
	else
	{
		NSArray *output = [classes copy];
		resultBlock(output, nil);
	}
	[self cleanup];
}
- (void)connection:(NSURLConnection *)theConnection
  didFailWithError:(NSError *)error
{
	resultBlock(nil, error);
	[self cleanup];
}

@end
