//
//  LAEventsTableViewController.m
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LAEventsTableViewController.h"


@implementation LAEventsTableViewController

@synthesize eventDatabase;

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self;
 }
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    
    filteredEvents = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(eventDatabaseUpdated) 
                                                 name: @"LAEventUpdated"  
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(eventDatabaseUpdated) 
                                                 name: @"LAEventDatabaseUpdated"  
                                               object: nil];
    
    [self eventDatabaseUpdated];
    //NSLog(@"eventDatabase: %@", [eventDatabase events]);
    //[[NSNotificationCenter defaultCenter] addObserver: [self tableView] selector: @selector(reloadData) name: @"LAEventsDatabaseUpdated" object: nil];
}

- (void) eventDatabaseUpdated {
    if (filteredEvents) {
        [filteredEvents release];
        filteredEvents = nil;
        filteredEvents = [[NSMutableArray alloc] init];
    }

    if (tableHeaderStrings) {
        [tableHeaderStrings release];
        tableHeaderStrings = nil;
    }

    [[self tableView] reloadData];
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

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
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return 1;
    }
	else
	{
        //NSLog(@"%d", [[eventDatabase uniqueDays] count]);
        return [[eventDatabase uniqueDays] count];
    }
    
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredEvents count];
    }
	else
	{
        NSDate *sectionDay = [[eventDatabase uniqueDays] objectAtIndex: section];
        return [[eventDatabase eventsOnDay: sectionDay] count];
    }
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"EventCell";

    LAEvent *event = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        event = [filteredEvents objectAtIndex:indexPath.row];
    }
	else
	{
        event = [self eventForRowAtIndexPath: indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	//NSLog(@"%@", [[LAEventDatabase sharedEventDatabase] starredEvents]);
    [[cell textLabel] setText: [event title]];
    [[cell detailTextLabel] setText: [event speaker]];
    [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

// Method to override if 
- (LAEvent *)eventForRowAtIndexPath:(NSIndexPath *)indexPath {
	LAEvent *event = nil;
	NSDate *sectionDay = [[eventDatabase uniqueDays] objectAtIndex: indexPath.section];
	event = [[eventDatabase eventsOnDay: sectionDay] objectAtIndex: indexPath.row];

	return event;
}

- (NSString *)tableView: (UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return nil;
    }
	else
	{
        if (tableHeaderStrings != nil) {
            return [tableHeaderStrings objectAtIndex: section];
        }
        
        [tableHeaderStrings release];
        tableHeaderStrings = [[NSMutableArray alloc] init];
        // Generate new table view headers
        NSEnumerator *uniqueDaysEnumerator = [[eventDatabase uniqueDays] objectEnumerator];
        NSDate *currentDate;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"EEEE, MMMM d yyyy"];
        
        while (currentDate = [uniqueDaysEnumerator nextObject]) {
            [tableHeaderStrings addObject: [dateFormatter stringFromDate: currentDate]];
        }
        
        [dateFormatter release];
        
        return [self tableView: tableView titleForHeaderInSection: section];
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
    
    LAEvent *selectedEvent = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        selectedEvent = [filteredEvents objectAtIndex:indexPath.row];
    }
	else
	{
        selectedEvent = [self eventForRowAtIndexPath: indexPath];
    }
    
    LAEventDetailViewController *eventDetailViewController = [[LAEventDetailViewController alloc] initWithNibName: @"LAEventDetailViewController" bundle: [NSBundle mainBundle]];
    [eventDetailViewController setEvent: selectedEvent];
    [[self navigationController] pushViewController: eventDetailViewController animated: YES];
    [eventDetailViewController release];
    
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[filteredEvents removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for events whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (LAEvent *event in [eventDatabase events])
	{
		
        NSRange titleResult = [[event title] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        NSRange speakerResult = [[event speaker] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        NSRange descriptionResult = [[event speaker] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        
        if ([scope isEqualToString: @"All"] && (titleResult.location != NSNotFound || speakerResult.location != NSNotFound || descriptionResult.location != NSNotFound))
        {
            [filteredEvents addObject:event];
        }
        if ([scope isEqualToString: @"Title"] && titleResult.location != NSNotFound)
        {
            [filteredEvents addObject:event];
        }
        if ([scope isEqualToString: @"Speaker"] && speakerResult.location != NSNotFound)
        {
            [filteredEvents addObject:event];
        }        
    }
}



#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (void)dealloc {
    [filteredEvents release];
    [super dealloc];
}

- (IBAction) refreshDatabase: (id) sender {

	UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(-140, -18, 280, 25)];
    [progressView setProgress: 0.0];
    [progressView setProgressViewStyle: UIProgressViewStyleBar];
    progressView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                     UIViewAutoresizingFlexibleRightMargin |
                                     UIViewAutoresizingFlexibleTopMargin |
                                     UIViewAutoresizingFlexibleBottomMargin);
    downloadProgressBar = progressView;
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Downloading..."
                                                      delegate:self
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle: @"Cancel"
                                             otherButtonTitles:nil];
    downloadActionSheet = menu;
    
    [menu addSubview:progressView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0,0,320, 175)];
    

    
    NSURLRequest *databaseDownloadRequest = [NSURLRequest requestWithURL: [NSURL URLWithString: @"http://roubaix.landasoftware.com/fosdem_schedule.xcal"]];
    LADownload *fileDownload = [[LADownload alloc] initWithRequest:databaseDownloadRequest 
                                                       destination: [[self cachedDatabaseLocation] path] 
                                                          delegate: self];
    download = fileDownload;
    [fileDownload start];

}


- (NSURL*) cachedDatabaseLocation {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *cacheFileLocation = [cachesDirectory stringByAppendingPathComponent:@"fosdem_schedule.xcal"];
	
	return [NSURL fileURLWithPath: cacheFileLocation];
	
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    [download cancel];
    [download release];
    download = nil;
}

- (void)downloadDidFinish: (LADownload *) aDownload {
	[LAEventDatabase releaseMainEventDatabase];
    [downloadActionSheet dismissWithClickedButtonIndex: 0 animated: YES];
    [downloadActionSheet release];
    downloadActionSheet = nil;
    [downloadProgressBar release];
    downloadProgressBar = nil;
    
	[[self tableView] reloadData];
    [download release];
}

- (void)download: (LADownload *) aDownload didReceiveDataOfLength: (NSUInteger) dataLength {
    [downloadProgressBar setProgress: [download progress]];
    [downloadActionSheet setTitle: [NSString stringWithFormat:@"Downloading (%.2fMB/%.2fMB)", [aDownload receivedLength]/1024/1024, [aDownload totalLength]/1024/1024]];
}

@end

