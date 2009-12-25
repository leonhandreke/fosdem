//
//  LAEventDetailViewController.h
//  fosdem
//
//  Created by Leon on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

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
