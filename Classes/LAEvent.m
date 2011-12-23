/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

#import "LAEvent.h"


@implementation LAEvent

@synthesize identifier, title, subtitle, speaker, location, track, type, contentAbstract, contentDescription, startDate, endDate;

- (LAEvent *)init {

    if (self = [super init]) {

        // Set the following to an empty string in case they are not defined in the schedule file
        // Not doing this will reult in erroneous search results
        
        track = [[NSString alloc] init];
        speaker = [[NSString alloc] init];
        
    }
    
    return self;

}

/*
- (NSMutableDictionary *) userData {
	return [[LAEventDatabase sharedEventDatabase] userDataForEventWithIdentifier: [self identifier]];
}*/

- (BOOL) isStarred {

    return starred;

}


- (void) setStarred:(BOOL) isStarred {
    starred = isStarred;
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys: [self identifier], @"identifier", [NSNumber  numberWithBool: isStarred], @"starred", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"LAEventUpdated" 
                                                        object: self 
                                                      userInfo: infoDict];
}

- (NSComparisonResult) compareDateWithEvent: (LAEvent *) otherEvent {
	return [[self startDate] compare: [otherEvent startDate]];
}

@end
