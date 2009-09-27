//
//  LALectureDetailViewController.h
//  fosdem
//
//  Created by Leon on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TKOverviewHeaderView.h"
#import "LALecture.h"

@interface LALectureDetailViewController : UIViewController {

    LALecture *lecture;
    IBOutlet UIView *headerHolderView;
    IBOutlet UIWebView *webView;
    
}

- (BOOL)hidesBottomBarWhenPushed;

@property (assign) LALecture *lecture;
@end
