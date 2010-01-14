//
//  LAEventCell.m
//  fosdem
//
//  Created by Adam Ziolkowski on 14/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LAEventTableViewCell.h"

@implementation LAEventTableViewCell

@synthesize titleLabel, subtitleLabel, timeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
