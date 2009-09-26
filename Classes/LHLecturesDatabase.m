//
//  LHLecturesDatabase.m
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LHLecturesDatabase.h"


@implementation LHLecturesDatabase


@synthesize lectures;

static LHLecturesDatabase *mainLecturesDatabase = nil;

+ (LHLecturesDatabase *) sharedLecturesDatabase
{
	if(mainLecturesDatabase == nil) {
        // Try to load from the resource bundle first
        NSDictionary *lecturesDictionary = [NSDictionary dictionaryWithContentsOfFile: [self lecturesDatabaseLocation]];
        if (lecturesDictionary != nil) {
            mainLecturesDatabase = [[LHLecturesDatabase alloc] initWithDictionary: lecturesDictionary];
        }
        else {
            mainLecturesDatabase = [[LHLecturesDatabase alloc] init];
        }		
    }
    return mainLecturesDatabase;	
}


- (LHLecturesDatabase*) init {
    if (self = [super init]) {
        lectures = [[NSMutableArray alloc] init];        
    }
    return self;
}

- (LHLecturesDatabase*) initWithDictionary: (NSDictionary *) dictionary {
    if (self = [super init]) {
        lectures = [[NSMutableArray alloc] init];
        
        NSEnumerator *dictionaryEnumetator = [[dictionary allValues] objectEnumerator];
        NSDictionary *currentDictionary;
        
        while (currentDictionary = [dictionaryEnumetator nextObject]) {
            [lectures addObject: [[LHLecturesDatabase alloc] initWithDictionary: currentDictionary]];
        }
        
        
    }
    return self;
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
