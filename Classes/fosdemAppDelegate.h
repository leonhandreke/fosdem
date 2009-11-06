//
//  fosdemAppDelegate.h
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LAEventDatabase.h"
#import "LAEventsTableViewController.h"

@interface fosdemAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	
	IBOutlet LAEventsTableViewController *eventsTableViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
