//
//  LALecturesTableViewController.m
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LALecturesTableViewController.h"


@implementation LALecturesTableViewController

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
    
    filteredLectures = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[[[self tabBarController] navigationItem] setTitle: NSLocalizedString(@"Lectures", @"Lectures")];
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
        return [[[LALecturesDatabase sharedLecturesDatabase] uniqueDays] count];
    }
    
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredLectures count];
    }
	else
	{
        NSDate *sectionDay = [[[LALecturesDatabase sharedLecturesDatabase] uniqueDays] objectAtIndex: section];
        return [[[LALecturesDatabase sharedLecturesDatabase] lecturesOnDay: sectionDay] count];
    }
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"LectureCell";
    
    NSDate *sectionDay = [[[LALecturesDatabase sharedLecturesDatabase] uniqueDays] objectAtIndex: indexPath.section];
    
    LALecture *lecture = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        lecture = [filteredLectures objectAtIndex:indexPath.row];
    }
	else
	{
        lecture = [[[LALecturesDatabase sharedLecturesDatabase] lecturesOnDay: sectionDay] objectAtIndex: indexPath.row];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	
    [[cell textLabel] setText: [lecture title]];
    [[cell detailTextLabel] setText: [lecture speaker]];
    [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (NSString *)tableView: (UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return nil;
    }
	else
	{
        NSDate *sectionDay = [[[LALecturesDatabase sharedLecturesDatabase] uniqueDays] objectAtIndex: section];
        
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat: @"EEEE, MMMM d"];
        return [dateFormatter stringFromDate: sectionDay];
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
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
	
	[filteredLectures removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for lectures whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (LALecture *lecture in [[LALecturesDatabase sharedLecturesDatabase] lectures])
	{
		
        NSRange titleResult = [[lecture title] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        NSRange speakerResult = [[lecture speaker] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        NSRange descriptionResult = [[lecture speaker] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        
        if ([scope isEqualToString: @"All"] && (titleResult.location != NSNotFound || speakerResult.location != NSNotFound || descriptionResult.location != NSNotFound))
        {
            [filteredLectures addObject:lecture];
        }
        if ([scope isEqualToString: @"Title"] && titleResult.location != NSNotFound)
        {
            [filteredLectures addObject:lecture];
        }
        if ([scope isEqualToString: @"Speaker"] && speakerResult.location != NSNotFound)
        {
            [filteredLectures addObject:lecture];
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
    [filteredLectures release];
    [super dealloc];
}


@end

