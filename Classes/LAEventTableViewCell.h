/* ----------------------------------------------------------------------------
* "THE BEER-WARE LICENSE" (Revision 42):
* Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
* wrote this file. As long as you retain this notice you
* can do whatever you want with this stuff. If we meet some day, and you think
* this stuff is worth it, you can buy us a beer in return.
* ----------------------------------------------------------------------------
*/

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
