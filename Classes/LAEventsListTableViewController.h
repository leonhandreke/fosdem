//
//  LAEventsListTableViewController.h
//  fosdem
//
//  Created by Adam Ziolkowski on 26/12/2012.
//
//

#import <UIKit/UIKit.h>

@class LAEventCollection;

@interface LAEventsListTableViewController : UITableViewController

-(id) init;

@property (nonatomic, retain) LAEventCollection *events;
@property (nonatomic, retain) NSDateFormatter *timeDateFormatter;
@property (nonatomic, retain) NSDateFormatter *sectionDateFormatter;

@end
