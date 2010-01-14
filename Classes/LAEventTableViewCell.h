//
//  LAEventCell.h
//  fosdem
//
//  Created by Adam Ziolkowski on 14/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LAEventTableViewCell : UITableViewCell {

	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *subtitleLabel;
	IBOutlet UILabel *timeLabel;
}


@property (assign) IBOutlet UILabel *titleLabel;
@property (assign) IBOutlet UILabel *subtitleLabel;
@property (assign) IBOutlet UILabel *timeLabel;


@end
