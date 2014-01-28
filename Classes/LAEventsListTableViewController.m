//
//  LAEventsListTableViewController.m
//  fosdem
//
//  Created by Adam Ziolkowski on 26/12/2012.
//
//

#import "LAEventsListTableViewController.h"

#import "LAEvent.h"
#import "LAEventCollection.h"

#import "LAEventTableViewCell.h"
#import "LAEventDetailViewController.h"

@interface LAEventsListTableViewController ()

@end

@implementation LAEventsListTableViewController

@synthesize timeDateFormatter;
@synthesize sectionDateFormatter;
@synthesize events;

/*- (id)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

-(id) init {

    self = [super init];
    
    if (self){
    
        [self setEvents: [[LAEventCollection alloc] init]];
        
    }
    
    return self;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    timeDateFormatter = [[NSDateFormatter alloc] init];
	[timeDateFormatter setDateFormat: @"HH:mm"];
    [timeDateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 3600]];
    
    sectionDateFormatter = [[NSDateFormatter alloc] init];
    [sectionDateFormatter setDateFormat: @"EEEE, MMMM d yyyy"];
    [sectionDateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 3600]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of unique days in the event collection.
    
    return [[events uniqueDays] count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[events eventsOnDay] objectForKey: (NSDate*)[[events uniqueDays] objectAtIndex: section]] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"LAEventTableViewCell";
    
    NSDate *eventDate = [[events uniqueDays] objectAtIndex: [indexPath section]];
    LAEvent *event = [[[events eventsOnDay] objectForKey: eventDate] objectAtIndex: [indexPath row]];
    
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

- (NSString *)tableView: (UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    // Get the date of the section
    
    NSDate *date = [[events uniqueDays] objectAtIndex: section];
    
    // Return string from date
    
    return [sectionDateFormatter stringFromDate: date];
    
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDate *date = [[events uniqueDays] objectAtIndex: [indexPath section]];
    
    LAEvent *selectedEvent = [[[events eventsOnDay] objectForKey: date] objectAtIndex: [indexPath row]];
    
    LAEventDetailViewController *eventDetailViewController = [[LAEventDetailViewController alloc] initWithNibName: @"LAEventDetailViewController" bundle: [NSBundle mainBundle]];
    
    [eventDetailViewController setEvent: selectedEvent];
    [[self navigationController] pushViewController: eventDetailViewController animated: YES];
    
}

@end
