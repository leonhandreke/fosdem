/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

#import "LATracksTableViewController.h"

#import "LAEventCollection.h"

#import "LAEventsListTableViewController.h"


@implementation LATracksTableViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(eventDatabaseUpdated)
                                                 name: @"LAEventDatabaseUpdated"
                                               object: nil];
    
}

- (void)eventDatabaseUpdated {

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
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return [[[LAEventDatabase sharedEventDatabase] tracks] count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    }
	
	[[cell textLabel] setText: [[[LAEventDatabase sharedEventDatabase] tracks] objectAtIndex: [indexPath row]]];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Create the collection of events
    
	LAEventCollection *eventCollection = [[LAEventCollection alloc] init];
    NSString *selectedTrack = [[[LAEventDatabase sharedEventDatabase] tracks] objectAtIndex: [indexPath row]];
    [eventCollection addEvents: [[LAEventDatabase sharedEventDatabase] eventsForTrack: selectedTrack]];
    
    // Load the detail view nib
    
    LAEventsListTableViewController *eventTableViewController = [[LAEventsListTableViewController alloc] initWithNibName: @"LAEventsListTableViewController" bundle: [NSBundle mainBundle]];
    
	// Push the view controller
	
    [eventTableViewController setEvents: eventCollection];
    [eventTableViewController setTitle: selectedTrack];
	[[self navigationController] pushViewController: eventTableViewController animated: YES];
	
}


@end

