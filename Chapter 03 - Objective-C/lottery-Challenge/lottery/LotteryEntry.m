//
//  LotteryEntry.m
//  lottery
//
//  Created by Adam Preble on 9/9/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "LotteryEntry.h"

@implementation LotteryEntry
- (id)init {
    return [self initWithEntryDate:[NSDate date]];
}
- (id)initWithEntryDate:(NSDate *)theDate {
    self = [super init];
    if (self)
    {
		NSAssert(theDate != nil, @"Argument must be non-nil");
		entryDate = theDate;
        firstNumber = ((int)random() % 100) + 1;
        secondNumber = ((int)random() % 100) + 1;
    }
    return self;
}
- (void)setEntryDate:(NSDate *)date
{
	entryDate = date;
}
- (NSDate *)entryDate
{
    return entryDate;
}
- (int)firstNumber
{
    return firstNumber;
}
- (int)secondNumber
{
    return secondNumber;
}
- (NSString *)description
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	// Note with the Unicode format string format, you should enclose literal text in the format string between apostrophes ('').
	[df setDateFormat:@"'Ranch time:' yyyy.MM.dd '@' H 'hours' 'and' m 'minutes'"];
    NSString *result;
    result = [[NSString alloc] initWithFormat:@"%@ = %d and %d",
              [df stringFromDate:entryDate],
              firstNumber, secondNumber];
    return result;
}
@end
