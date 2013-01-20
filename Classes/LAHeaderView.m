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
@synthesize indicatorPlaceholder;

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
        indicator.shadowColor = [UIColor whiteColor];
        indicator.textColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
        indicator.shadowOffset = CGSizeMake(0,1);
        
        indicatorPlaceholder = [[UIView alloc] initWithFrame: [indicator frame]];
        
        [self setBackgroundColor: [UIColor clearColor]];
        self.backgroundColor = [UIColor clearColor];
        
    
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    // Generate a gradient
    
    CAGradientLayer *backgroundGradient = [CAGradientLayer layer];
    [backgroundGradient setFrame: rect];
    NSArray *bgGradientColors = [NSArray arrayWithObjects:
                                (id)[[UIColor colorWithRed:0.7843 green:0.8117 blue:0.8313 alpha:1.0] CGColor],
                                (id)[[UIColor colorWithRed:0.6627 green:0.6980 blue:0.7254 alpha:1.0] CGColor],
                                 nil];
    [backgroundGradient setColors: bgGradientColors];
    
    // Add a dropshadow to the background layer
    
    [backgroundGradient setShadowOffset: CGSizeMake(0, 5)];
    [backgroundGradient setShadowRadius: 5];
    [backgroundGradient setShadowOpacity: 0.4];
    
    // Create a layer for the bottom border
    
    CALayer *border = [CALayer layer];
    [border setFrame: CGRectMake(0, rect.size.height, rect.size.width, 1.0)];
    [border setBackgroundColor: [[UIColor colorWithWhite:0.2f alpha:0.5f] CGColor]];
    
    // Create a gradient background for the indicator label
    
    CALayer *indicatorLabel = [CALayer layer];
    [indicatorLabel setFrame: [indicatorPlaceholder bounds]];
    [indicatorLabel setBackgroundColor: [[UIColor colorWithRed: 0.2 green:0.6 blue:0.8 alpha: 1.0] CGColor]];
    [indicatorLabel setCornerRadius: 6];
    [[indicatorPlaceholder layer] insertSublayer: indicatorLabel atIndex: 0];
    [indicatorPlaceholder addSubview: indicator];
    
    // Draw the generated gradient
    
    [[self layer] addSublayer: backgroundGradient];
    [[self layer] addSublayer: border];
    
    // Draw the Labels
    
    [self addSubview:title];
    [self addSubview:subtitle];
    [self addSubview:indicator];
    
    
}


@end
