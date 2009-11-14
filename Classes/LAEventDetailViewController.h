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

@interface LAEventDetailViewController : UIViewController {

    LAEvent *event;
    IBOutlet UIView *headerHolderView;
    IBOutlet UIWebView *webView;
    
}

-(BOOL)hidesBottomBarWhenPushed;
-(IBAction) bookmarkItem: (id) sender;

@property (assign) LAEvent *event;
@end
