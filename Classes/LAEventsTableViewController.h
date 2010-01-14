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
#import "LAEventTableViewCell.h"

@interface LAEventsTableViewController : UITableViewController <UIActionSheetDelegate> {
    NSMutableArray *filteredEvents;
    
    NSMutableArray *tableHeaderStrings;
	UIProgressView *downloadProgressBar;
    UIActionSheet *downloadActionSheet;
    LADownload *download;
	
	IBOutlet LAEventTableViewCell *eventCell;
	
}

- (void) eventDatabaseUpdated;

- (LAEvent *)eventForRowAtIndexPath:(NSIndexPath *)indexPath;

- (IBAction) refreshDatabase: (id) sender;

- (void)actionSheetCancel:(UIActionSheet *)actionSheet;
- (void)downloadDidFinish: (LADownload *) aDownload;

- (void)download: (LADownload *) aDownload didReceiveDataOfLength: (NSUInteger) dataLength;

@property (nonatomic, assign) IBOutlet LAEventTableViewCell *eventCell;

@end
