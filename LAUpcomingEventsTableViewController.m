/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

#import "LAUpcomingEventsTableViewController.h"


@implementation LAUpcomingEventsTableViewController

@synthesize baseDate;
@synthesize eventsNow;
@synthesize eventsSoon;

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
	
	// Always use an up-to-date date
	
    baseDate = [NSDate date];
    
	// I know caching it here is evil but I have deadlines :)
    
	eventsNow = [[LAEventDatabase sharedEventDatabase] eventsWhile: baseDate];
	eventsSoon = [[LAEventDatabase sharedEventDatabase] eventsInTimeInterval: 3600 afterDate: baseDate];
	
    if ([eventsNow count] == 0 && [eventsSoon count] == 0){
    
        // FOSDEM has not started
        
    }
    
	[[self tableView] reloadData];
    
}

- (void)didReceiveMemoryWarning {
    
	// Releases the view if it doesn't have a superview.
    
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
    
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// One "Now", one next hour
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return [eventsNow count];
	}
	else {
		return [eventsSoon count];
	}
}

- (LAEvent *)eventForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		return [eventsNow objectAtIndex: indexPath.row];
	}
	else {
		return [eventsSoon objectAtIndex: indexPath.row];
	}
}


- (NSString *)tableView: (UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
		return @"Now";
	}
	else {
		return @"Next hour";
	}

}


@end

