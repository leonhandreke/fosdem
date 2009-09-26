//
//  fosdemAppDelegate.m
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "fosdemAppDelegate.h"


@implementation fosdemAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:navigationController.view];
    [navigationController pushViewController: tabBarController animated: NO];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

