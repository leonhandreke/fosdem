//
//  LAEventsTableViewController.h
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LAEventDetailViewController.h"

#import "LAEventDatabase.h"
#import "LAEvent.h"

@interface LAEventsTableViewController : UITableViewController {
	
	LAEventDatabase *eventDatabase;
    NSMutableArray *filteredEvents;
}

@property (assign) LAEventDatabase *eventDatabase;

@end
