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
#import "LADownload.h"

@interface LAEventsTableViewController : UITableViewController <UIActionSheetDelegate> {
    NSMutableArray *filteredEvents;
    
    NSMutableArray *tableHeaderStrings;
	UIProgressView *downloadProgressBar;
    UIActionSheet *downloadActionSheet;
    LADownload *download;
	
}

- (void) eventDatabaseUpdated;

- (LAEvent *)eventForRowAtIndexPath:(NSIndexPath *)indexPath;

- (IBAction) refreshDatabase: (id) sender;
- (NSURL*) cachedDatabaseLocation;

- (void)actionSheetCancel:(UIActionSheet *)actionSheet;
- (void)downloadDidFinish: (LADownload *) aDownload;

- (void)download: (LADownload *) aDownload didReceiveDataOfLength: (NSUInteger) dataLength;

@property (assign) LAEventDatabase *eventDatabase;

@end
