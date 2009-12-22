//
//  LAStarredTableViewController.m
//  fosdem
//
//  Created by Leon on 11/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LAStarredTableViewController.h"


@implementation LAStarredTableViewController


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredEvents count];
    }
	else
	{
        return [[[LAEventDatabase sharedEventDatabase] starredEvents] count];
    }
    
}

// Method to override if 
- (LAEvent *)eventForRowAtIndexPath:(NSIndexPath *)indexPath {
	LAEvent *event = nil;
	event = [[[LAEventDatabase sharedEventDatabase] starredEvents] objectAtIndex: indexPath.row];
	return event;
}

- (NSString *)tableView: (UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}


@end

