/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

@implementation NSDate (Extend)

- (BOOL)isBetweenDate:(NSDate *)dateStart andDate:(NSDate *)dateEnd {
	if ([self compare:dateEnd] == NSOrderedDescending)
		return NO;
	
	if ([self compare:dateStart] == NSOrderedAscending) 
		return NO;
	
	return YES;
}

- (BOOL)isBeforeDate:(NSDate *)date {

    if ([self compare:date] == NSOrderedAscending)
        return YES;
    
    return NO;
    
}

- (NSDate*)getRoundedDate {

    NSDateComponents *dateComponents = [[NSCalendar autoupdatingCurrentCalendar] components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: self];
    
    return [[NSCalendar autoupdatingCurrentCalendar] dateFromComponents:dateComponents];;

}

@end