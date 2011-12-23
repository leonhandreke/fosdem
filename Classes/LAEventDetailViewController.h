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

#import "TKOverviewHeaderView.h"
#import "LAEvent.h"
#import "LAEventDatabase.h"

@interface LAEventDetailViewController : UIViewController {

    LAEvent *event;
    IBOutlet UIView *headerHolderView;
    IBOutlet UIWebView *webView;
    
    IBOutlet UIToolbar *toolbar;
    
}

- (BOOL)hidesBottomBarWhenPushed;

- (IBAction) toggleStarred: (id) sender;
- (void) updateToolbar;

@property (assign) LAEvent *event;

@end
