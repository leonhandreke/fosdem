//
//  LALecturesDatabase.m
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LALecturesDatabase.h"


@implementation LALecturesDatabase


@synthesize lectures;

static LALecturesDatabase *mainLecturesDatabase = nil;

+ (LALecturesDatabase *) sharedLecturesDatabase
{
	if(mainLecturesDatabase == nil) {
        // Try to load from the resource bundle first
        NSDictionary *lecturesDictionary = [NSDictionary dictionaryWithContentsOfFile: [self lecturesDatabaseLocation]];
        if (lecturesDictionary != nil) {
            mainLecturesDatabase = [[LALecturesDatabase alloc] initWithDictionary: lecturesDictionary];
            NSLog(@"%@", [mainLecturesDatabase uniqueDays]);
        }
        else {
            mainLecturesDatabase = [[LALecturesDatabase alloc] init];
        }		
    }
    return mainLecturesDatabase;	
}


- (LALecturesDatabase*) init {
    if (self = [super init]) {
        lectures = [[NSMutableArray alloc] init];        
    }
    return self;
}

- (LALecturesDatabase*) initWithDictionary: (NSDictionary *) dictionary {
    if (self = [super init]) {
        lectures = [[NSMutableArray alloc] init];
        NSEnumerator *dictionaryEnumetator = [[dictionary allValues] objectEnumerator];
        NSDictionary *currentDictionary;
        
        while (currentDictionary = [dictionaryEnumetator nextObject]) {
            [lectures addObject: [[LALecture alloc] initWithDictionary: currentDictionary]];
        }
    }
    return self;
}

- (NSArray *) uniqueDays {

    if (cachedUniqueDays != nil) {
        return cachedUniqueDays;
    }
    
    NSEnumerator *lecturesEnumerator = [lectures objectEnumerator];
    LALecture *currentLecture;
    
    NSMutableArray *uniqueDays = [[NSMutableArray alloc] init];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    while (currentLecture = [lecturesEnumerator nextObject]) {
        NSDateComponents *currentLectureDateComponents = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: [currentLecture startDate]];
        
        // In case there is no unique day yet we just add it straight away
        if ([uniqueDays count] == 0) {
            [currentLectureDateComponents setSecond: 0];
            [currentLectureDateComponents setMinute: 0];
            [currentLectureDateComponents setHour: 0];
            
            [uniqueDays addObject: [calendar dateFromComponents: currentLectureDateComponents]];
        }
        
        NSEnumerator *uniqueDaysEnumerator = [uniqueDays objectEnumerator];
        NSDate *currentUniqueDay;
        
        while (currentUniqueDay = [uniqueDaysEnumerator nextObject]) {
            NSDateComponents *uniqueDayDateComponents = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: currentUniqueDay];
            if([uniqueDayDateComponents day] == [currentLectureDateComponents day] && \
               [uniqueDayDateComponents month] == [currentLectureDateComponents month] && \
               [uniqueDayDateComponents year] == [currentLectureDateComponents year]) {
                // Same date - obviously (imagine Ali-G voice here...)
            }
            else {
                // Same shit, different day
                [currentLectureDateComponents setSecond: 0];
                [currentLectureDateComponents setMinute: 0];
                [currentLectureDateComponents setHour: 0];
                
                [uniqueDays addObject: [calendar dateFromComponents: currentLectureDateComponents]];
                // We have found that the lecture has a unique day - we no longer need to go through all the other unique days
                break;
            }
        }        
    }
    
    cachedUniqueDays = uniqueDays;
    return uniqueDays;
}

- (NSArray *) lecturesOnDay: (NSDate *) dayDate {
    NSEnumerator *lecturesEnumerator = [lectures objectEnumerator];
    LALecture *currentLecture;
    
    NSMutableArray *lecturesOnDay = [NSMutableArray array];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    while (currentLecture = [lecturesEnumerator nextObject]) {
        NSDateComponents *currentLectureDateComponents = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: [currentLecture startDate]];
        NSDateComponents *lectureDateComponents = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: dayDate];
        
        if([lectureDateComponents day] == [currentLectureDateComponents day] && \
           [lectureDateComponents month] == [currentLectureDateComponents month] && \
           [lectureDateComponents year] == [currentLectureDateComponents year]) {
            // Obviously the lecture is on the same day
            [lecturesOnDay addObject: currentLecture];
        }
    }    
    return lecturesOnDay;
}

+ (NSString *) lecturesDatabaseLocation {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *cacheFileLocation = [cachesDirectory stringByAppendingPathComponent:@"lecturesDatabaseCache.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath: cacheFileLocation]) {
        return cacheFileLocation;
    }
        
    NSString *resourcesDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *resourceFileLocation = [resourcesDirectory stringByAppendingPathComponent:@"lecturesDatabase.plist"];
    return resourceFileLocation;
         
}


@end
