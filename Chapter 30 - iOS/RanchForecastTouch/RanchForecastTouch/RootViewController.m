//
//  RootViewController.m
//  RanchForecastTouch
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "RootViewController.h"
#import "ScheduleFetcher.h"
#import "ScheduleViewController.h"

@implementation RootViewController
@synthesize fetchButton;
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		[[self navigationItem] setTitle:@"Ranch Forecast"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)fetchClasses:(id)sender
{
	[activityIndicator startAnimating];
	[fetchButton setEnabled:NO];
	ScheduleFetcher *fetcher = [[ScheduleFetcher alloc] init];
	[fetcher fetchClassesWithBlock:
	 ^(NSArray *classes, NSError *error) {
		 [fetchButton setEnabled:YES];
		 [activityIndicator stopAnimating];
		 if (classes) {
			 ScheduleViewController *svc;
			 svc = [[ScheduleViewController alloc]
					initWithStyle:UITableViewStylePlain];
			 [svc setClasses:classes];
			 [self.navigationController pushViewController:svc
												  animated:YES];
		 } else {
			 UIAlertView *alert;
			 alert = [[UIAlertView alloc]
					  initWithTitle:@"Error Fetching Classes"
					  message:[error localizedDescription]
					  delegate:nil
					  cancelButtonTitle:@"Dismiss"
					  otherButtonTitles:nil];
			 [alert show];
		 }
	 }];
}
@end
