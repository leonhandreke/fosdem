//
//  LAHeaderView.h
//  fosdem
//
//  Created by Adam Ziolkowski on 04/12/2012.
//
//

#import <UIKit/UIKit.h>

@interface LAHeaderView : UIView

@property (nonatomic,retain) UILabel *title;
@property (nonatomic,retain) UILabel *subtitle;
@property (nonatomic,retain) UILabel *indicator;
@property (nonatomic,retain) UIView *indicatorPlaceholder;

@end
