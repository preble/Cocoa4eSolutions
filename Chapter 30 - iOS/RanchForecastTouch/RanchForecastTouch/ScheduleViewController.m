//
//  ScheduleViewController.m
//  RanchForecastTouch
//
//  Created by Adam Preble on 9/22/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduledClass.h"

@implementation ScheduleViewController

@synthesize classes;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterLongStyle];
		[[self navigationItem] setTitle:@"Schedule"];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows
	return [classes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	
	ScheduledClass *c = [classes objectAtIndex:[indexPath row]];
    
    NSString *details =  [NSString stringWithFormat:@"%@ - %@",
                          [dateFormatter stringFromDate:c.begin],
                          c.location];
	
    [[cell textLabel] setText:[c name]];
    [[cell detailTextLabel] setText:details];
	
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ScheduledClass *c = [classes objectAtIndex:[indexPath row]];
	NSURL *baseUrl = [NSURL URLWithString:@"http://www.bignerdranch.com/"];
	NSURL *url = [NSURL URLWithString:[c href] relativeToURL:baseUrl];
	
	// We'll do this programmatically by creating a webview and putting it in a view controller.
	// If this were a more involved feature, we might subclass UIViewController, put a UIWebView
	// in its xib, then instantiate that subclass here and push it.  The RootViewController is
	// an example of such a subclass, in that it has an associated xib.
	
	UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
	[webView loadRequest:[NSURLRequest requestWithURL:url]];
	
	UIViewController *vc = [[UIViewController alloc] init];
	vc.title = @"Web View";
	vc.view = webView;
	
	[self.navigationController pushViewController:vc animated:YES];
}

@end
