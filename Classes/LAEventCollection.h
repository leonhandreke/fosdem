/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

#import <Foundation/Foundation.h>

@class LAEvent;

@interface LAEventCollection : NSObject

-(id) init;
-(void) addEvent: (LAEvent*) newEvent;
-(void) addEvents: (NSArray*) newEvents;

@property (nonatomic, retain) NSMutableArray *events;
@property (nonatomic, retain) NSMutableArray *uniqueDays;
@property (nonatomic, retain) NSMutableDictionary *eventsOnDay;

@end
