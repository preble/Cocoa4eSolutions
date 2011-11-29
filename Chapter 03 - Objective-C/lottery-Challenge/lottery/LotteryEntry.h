//
//  LotteryEntry.h
//  lottery
//
//  Created by Adam Preble on 9/9/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryEntry : NSObject {
	NSDate *entryDate;
    int firstNumber;
    int secondNumber;
}
- (id)initWithEntryDate:(NSDate *)theDate;

- (void)setEntryDate:(NSDate *)date;
- (NSDate *)entryDate;
- (int)firstNumber;
- (int)secondNumber;

@end
