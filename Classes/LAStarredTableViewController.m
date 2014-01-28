/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

#import "LAStarredTableViewController.h"


@implementation LAStarredTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(eventDatabaseUpdated) 
                                                 name: @"LAEventUpdated"  
                                               object: nil];
}



#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [[self filteredEvents] count];
    }
	else
	{
        return [[[LAEventDatabase sharedEventDatabase] starredEvents] count];
    }
    
}


- (LAEvent *)eventForRowAtIndexPath:(NSIndexPath *)indexPath {
	LAEvent *event = nil;
	event = [[[LAEventDatabase sharedEventDatabase] starredEvents] objectAtIndex: indexPath.row];
	return event;
}

- (NSString *)tableView: (UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}


@end

