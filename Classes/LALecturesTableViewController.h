//
//  LALecturesTableViewController.h
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LALectureDetailViewController.h"

#import "LALecturesDatabase.h"
#import "LALecture.h"

@interface LALecturesTableViewController : UITableViewController {
    NSMutableArray *filteredLectures;
}
@end
