/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@landasoftware.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

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
	NSDateFormatter *timeDateFormatter;
	
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
