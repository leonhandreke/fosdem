/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

#import "LAEventsTableViewController.h"


@implementation LAEventsTableViewController

@synthesize eventCell;
@synthesize timeDateFormatter;
@synthesize filteredEvents;
@synthesize tableHeaderStrings;
@synthesize download;
@synthesize downloadActionSheet, downloadProgressBar;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    filteredEvents = [[NSMutableArray alloc] init];
    
	timeDateFormatter = [[NSDateFormatter alloc] init];
	[timeDateFormatter setDateFormat: @"HH:mm"];
    [timeDateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 3600]];
	
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(eventDatabaseUpdated) 
                                                 name: @"LAEventDatabaseUpdated"  
                                               object: nil];
    
}

- (void) eventDatabaseUpdated {
    
    if (filteredEvents) {
        filteredEvents = nil;
        filteredEvents = [[NSMutableArray alloc] init];
    }
	
    if (tableHeaderStrings) {
        tableHeaderStrings = nil;
    }
    
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return 1;
    }
	else
	{
        return [[[LAEventDatabase sharedEventDatabase] uniqueDays] count];
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
        NSDate *sectionDay = [[[LAEventDatabase sharedEventDatabase] uniqueDays] objectAtIndex: section];
        return [[[LAEventDatabase sharedEventDatabase] eventsOnDay: sectionDay] count];
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
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LAEventTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex: 0];
        
    }
    
    [[(LAEventTableViewCell*)cell titleLabel] setText: [event title]];
    [[(LAEventTableViewCell*)cell subtitleLabel] setText: [event speaker]];
    [[(LAEventTableViewCell*)cell timeLabel] setText: [timeDateFormatter stringFromDate: [event startDate]]];

    return cell;
    
}

// Method to override if 
- (LAEvent *)eventForRowAtIndexPath:(NSIndexPath *)indexPath {
	LAEvent *event = nil;
	NSDate *sectionDay = [[[LAEventDatabase sharedEventDatabase] uniqueDays] objectAtIndex: indexPath.section];
	event = [[[LAEventDatabase sharedEventDatabase] eventsOnDay: sectionDay] objectAtIndex: indexPath.row];
	
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
        
        tableHeaderStrings = [[NSMutableArray alloc] init];
        // Generate new table view headers
        NSEnumerator *uniqueDaysEnumerator = [[[LAEventDatabase sharedEventDatabase] uniqueDays] objectEnumerator];
        NSDate *currentDate;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"EEEE, MMMM d yyyy"];
        
        while (currentDate = [uniqueDaysEnumerator nextObject]) {
            [tableHeaderStrings addObject: [dateFormatter stringFromDate: currentDate]];
        }
        
        return [self tableView: tableView titleForHeaderInSection: section];
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
}

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
	for (LAEvent *event in [[LAEventDatabase sharedEventDatabase] events])
	{
		
        NSRange titleResult = [[event title] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        NSRange speakerResult = [[event speaker] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        NSRange descriptionResult = [[event contentDescription] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        
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


- (IBAction) refreshDatabase: (id) sender {
    
    // Create an action sheet to display while downloading
    
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Downloading..."
                                                      delegate:self
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle: @"Cancel"
                                             otherButtonTitles:nil];
    
    [menu showFromTabBar: [[self tabBarController] tabBar]];
    [menu setBounds: CGRectMake(0,0,320, 175)];
    
    // Create a progress bar
        
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, 280, 90)];
    [progressView setCenter: CGPointMake(menu.center.x,110)];
    [progressView setProgress: 0.0];
    [progressView setProgressViewStyle: UIProgressViewStyleBar];
    progressView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                     UIViewAutoresizingFlexibleRightMargin |
                                     UIViewAutoresizingFlexibleTopMargin |
                                     UIViewAutoresizingFlexibleBottomMargin);
    
    // Store pointers to the progress bar and the action sheet
    
    downloadProgressBar = progressView;
    downloadActionSheet = menu;
    
    // Add the progress view to the action sheet
    
    [menu addSubview:progressView];
     
    NSURLRequest *databaseDownloadRequest = [NSURLRequest requestWithURL: [NSURL URLWithString: @"http://fosdem.org/schedule/xcal"]];
    LADownload *fileDownload = [[LADownload alloc] initWithRequest:databaseDownloadRequest 
                                                       destination: [LAEventDatabase cachedDatabaseLocation] 
                                                          delegate: self];
    download = fileDownload;
    [fileDownload start];
	
}




- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    [download cancel];
    download = nil;
}

- (void)downloadDidFinish: (LADownload *) aDownload {
	[LAEventDatabase resetMainEventDatabase];
    
    [downloadActionSheet dismissWithClickedButtonIndex: 0 animated: YES];
    downloadActionSheet = nil;

    downloadProgressBar = nil;
    download = nil;
}

- (void)download: (LADownload *) aDownload didReceiveDataOfLength: (NSUInteger) dataLength {
    [downloadProgressBar setProgress: [download progress]];
    [downloadActionSheet setTitle: [NSString stringWithFormat:@"Downloading (%.2fMB/%.2fMB)", [aDownload receivedLength]/1024/1024, [aDownload totalLength]/1024/1024]];
}

@end

