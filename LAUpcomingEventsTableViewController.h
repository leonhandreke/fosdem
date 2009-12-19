//
//  LAUpcomingEventsTableViewController.h
//  fosdem
//
//  Created by Leon on 12/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LAEventsTableViewController.h"

@interface LAUpcomingEventsTableViewController : LAEventsTableViewController {

	// This is required - it has to be set before doing anything with the view
	NSDate *baseDate;
	// This is quite simplistic and inelegant for now; Sorry
	NSArray *eventsNow;
	NSArray *eventsSoon;
}

//@property (retain) NSDate *baseDate;
@end
