/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

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
