//
//  ScheduleViewController.h
//  RanchForecastTouch
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UITableViewController {
	NSArray *classes;
	NSDateFormatter *dateFormatter;
}

@property (nonatomic, strong) NSArray *classes;

@end
