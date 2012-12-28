/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

#import "LAEventDetailViewController.h"


@implementation LAEventDetailViewController

@synthesize event;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    LAHeaderView *overviewHeaderView = [[LAHeaderView alloc] init];
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
   
    [[overviewHeaderView title] setText: [event speaker]];

    [dateFormatter setDateFormat: @"EEEE"];
    NSString *dayString = [dateFormatter stringFromDate: [event startDate]];
    [dateFormatter setDateFormat: @"H:mm"];
    //NSLog(@"dayString: %@", dayString);
    NSString *timeString = [NSString stringWithFormat: @"%@ - %@", [dateFormatter stringFromDate: [event startDate]], [dateFormatter stringFromDate: [event endDate]]];
    
    [[overviewHeaderView subtitle] setText: [NSString stringWithFormat: @"%@, %@", dayString, timeString]];
    
    
    [[overviewHeaderView indicator] setText: [event location]];
    
    [headerHolderView addSubview: overviewHeaderView];
    
    NSString *resourcePath = [[NSBundle mainBundle] bundlePath];
    NSURL *resourceURL = [NSURL fileURLWithPath: resourcePath];
    
	// Define description incase is returns blank for the database
	
	NSString *description;	
	if ([event contentDescription]){
		description = [event contentDescription];
	} else {
		description = @"No description could be found!";
	}
	
    NSString *templateString = [NSString stringWithContentsOfFile: [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"template.html"] encoding: NSUTF8StringEncoding error:nil];
    NSString *HTMLString = [NSString stringWithFormat: templateString, [event title], description, [[LAEventDatabase sharedEventDatabase] mapHTMLForEvent: event]];
    [webView loadHTMLString: HTMLString  baseURL: resourceURL];
    
    // Initialize the toolbar
    [self updateToolbar];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (BOOL)hidesBottomBarWhenPushed {
	return TRUE;
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


- (void)dealloc {
    [super dealloc];
}

-(IBAction) toggleStarred: (id) sender {
	if ([[self event] isStarred]) {
		[[self event] setStarred: NO];
	}
	else {
		[[self event] setStarred: YES];
	}
    [self updateToolbar];
}

- (void) updateToolbar {
    
    UIBarButtonItem *button;
    UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil] autorelease];
    if([[self event] isStarred]) {
        button = [[[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"StarOn.png"] style:UIBarButtonItemStylePlain target: self action: @selector(toggleStarred:)] autorelease];
        
    }
    else {
        button = [[[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"StarOff.png"] style: UIBarButtonItemStylePlain target: self action: @selector(toggleStarred:)] autorelease];
    }
    NSArray *toolbarItems = [NSArray arrayWithObjects: flexibleSpace, button, flexibleSpace, nil];
    [toolbar setItems: toolbarItems];
    
}

@end
