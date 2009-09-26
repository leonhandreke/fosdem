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
            [lectures addObject: [[LALecturesDatabase alloc] initWithDictionary: currentDictionary]];
        }
    }
    return self;
}

- (NSArray *) uniqueDays {

    NSEnumerator *lecturesEnumerator = [lectures objectEnumerator];
    LALecture *currentLecture;
    
    NSMutableArray *uniqueDays = [NSMutableArray array];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    while (currentLecture = [lecturesEnumerator nextObject]) {
        NSDateComponents *dateComponents = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: [currentLecture startDate]];
        
        NSEnumerator *uniqueDaysEnumerator = [uniqueDays objectEnumerator];
        NSDate *currentUniqueDay;
        
        while (currentUniqueDays = [uniqueDaysEnumerator nextObject]) {
            
        }        
    }
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
