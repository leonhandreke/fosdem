/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

#import <QuartzCore/QuartzCore.h>
#import "LAHeaderView.h"

@implementation LAHeaderView

@synthesize title;
@synthesize subtitle;
@synthesize indicator;

- (id)init {
    
    self = [super initWithFrame: CGRectMake(0,0,320,70)];
    
    if (self) {
        CGRect rect = CGRectMake(0,0,320,70);
        
        // Create the title label and attach it to the view
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, 200, 23)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont boldSystemFontOfSize:22.0];
        title.adjustsFontSizeToFitWidth = YES;
        
        
        // Create the subtitle and attach it to the view
        
        subtitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 39, 200, 22)];
        subtitle.backgroundColor = [UIColor clearColor];
        subtitle.font = [UIFont systemFontOfSize:16];
        subtitle.adjustsFontSizeToFitWidth = YES;
        subtitle.shadowColor = [UIColor whiteColor];
        subtitle.textColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
        subtitle.shadowOffset = CGSizeMake(0,1);
        
        // Create an indicator for the room
        
        indicator = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width*0.7, rect.size.height*0.25, rect.size.width*0.225, rect.size.height*0.5)];
        indicator.backgroundColor = [UIColor clearColor];
        indicator.font = [UIFont systemFontOfSize:16];
        indicator.adjustsFontSizeToFitWidth = YES;
        indicator.textAlignment = NSTextAlignmentCenter;
        
        // Set the background on the label
        
        [[[self indicator] layer] setBackgroundColor: [UIColor colorWithRed:0.15 green:0.48 blue:1.0 alpha:1].CGColor];
        [[[self indicator] layer] setCornerRadius: 2.0];
        [[self indicator] setTextColor: [UIColor whiteColor]];
        
        [self setBackgroundColor: [UIColor colorWithRed: 0.9725 green: 0.9725 blue:0.9725 alpha: 1.0]];
    
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    // Create a layer for the bottom border
    
    CALayer *border = [CALayer layer];
    [border setFrame: CGRectMake(0, rect.size.height, rect.size.width, 0.5f)];
    [border setBackgroundColor: [UIColor colorWithRed:0.6784 green:0.6784 blue:0.6784 alpha:1].CGColor];
    
    // Attach the bottom border to the view
    
    [[self layer] addSublayer: border];
    
    // Draw the Labels
    
    [self addSubview:title];
    [self addSubview:subtitle];
    [self addSubview:indicator];
    
    
}


@end
