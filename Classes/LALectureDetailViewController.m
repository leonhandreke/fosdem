//
//  LALectureDetailViewController.m
//  fosdem
//
//  Created by Leon on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LALectureDetailViewController.h"


@implementation LALectureDetailViewController

@synthesize lecture;

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
    UIFont *titleFont = [UIFont fontWithName: @"Helvetica-Bold" size: 13];
    [[overviewHeaderView title] setText: [lecture title]];
    [[overviewHeaderView title] setAdjustsFontSizeToFitWidth: NO];
    [[overviewHeaderView title] setFont: titleFont];
    

    [[overviewHeaderView subtitle] setText: [lecture speaker]];

    [headerHolderView addSubview: overviewHeaderView];
    
    NSString *resourcePath = [[NSBundle mainBundle] bundlePath];
    NSURL *resourceURL = [NSURL fileURLWithPath: resourcePath];
    [webView loadHTMLString: [lecture descriptionPage] baseURL: resourceURL];
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


@end
