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

@property (nonatomic, assign) LAEventCollection *events;
@property (nonatomic, assign) NSDateFormatter *timeDateFormatter;
@property (nonatomic, assign) NSDateFormatter *sectionDateFormatter;

@end
