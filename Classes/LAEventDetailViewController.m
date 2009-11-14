//
//  LAEventDetailViewController.m
//  fosdem
//
//  Created by Leon on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LAEventDetailViewController.h"


@implementation LAEventDetailViewController

@synthesize event;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    TKOverviewHeaderView *overviewHeaderView = [[TKOverviewHeaderView alloc] init];
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
   
    [[overviewHeaderView title] setText: [event speaker]];

    [dateFormatter setDateFormat: @"EEEE"];
    NSString *dayString = [dateFormatter stringFromDate: [event startDate]];
    [dateFormatter setDateFormat: @"H:mm"];
    NSString *timeString = [NSString stringWithFormat: @"%@ - %@", [dateFormatter stringFromDate: [event startDate]], [dateFormatter stringFromDate: [event endDate]]];
    
    [[overviewHeaderView subtitle] setText: [NSString stringWithFormat: @"%@, %@", dayString, timeString]];
    
    
    [[overviewHeaderView indicator] setColor: TKOverviewIndicatorViewColorBlue];
    [[overviewHeaderView indicator] setText: [event track]];
    
    [headerHolderView addSubview: overviewHeaderView];
    
    NSString *resourcePath = [[NSBundle mainBundle] bundlePath];
    NSURL *resourceURL = [NSURL fileURLWithPath: resourcePath];
    [webView loadHTMLString: [event contentDescription] baseURL: resourceURL];
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

-(IBAction) bookmarkItem: (id) sender {

	NSLog(@"Star");

}


@end
