//
//  LAEventDatabase.m
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LAEventDatabase.h"


@implementation LAEventDatabase


@synthesize events;

static LAEventDatabase *mainEventsDatabase = nil;

+ (LAEventDatabase *) sharedEventsDatabase
{
	if(mainEventsDatabase == nil) {
        /*// Try to load from the resource bundle first
         NSDictionary *eventsDictionary = [NSDictionary dictionaryWithContentsOfFile: [self eventsDatabaseLocation]];*/
        NSData *eventXMLData = [NSData dataWithContentsOfFile: [self eventDatabaseLocation]];
        if (eventXMLData != nil) {
            mainEventsDatabase = [[LAEventDatabase alloc] initWithData: eventXMLData];
        }
        else {
            mainEventsDatabase = [[LAEventDatabase alloc] init];
        }		
    }
    return mainEventsDatabase;	
}


- (LAEventDatabase*) init {
    if (self = [super init]) {
        events = [[NSMutableArray alloc] init];        
    }
    return self;
}
/*
 - (LAEventDatabase*) initWithDictionary: (NSDictionary *) dictionary {
 if (self = [super init]) {
 events = [[NSMutableArray alloc] init];
 NSEnumerator *dictionaryEnumetator = [[dictionary allValues] objectEnumerator];
 NSDictionary *currentDictionary;
 
 while (currentDictionary = [dictionaryEnumetator nextObject]) {
 [events addObject: [[LAEvent alloc] initWithDictionary: currentDictionary]];
 }
 }
 return self;
 }*/

- (LAEventDatabase *) initWithData: (NSData *) xmlData {
    if (self = [self init]) {
        LAEventsXMLParser *xmlParser = [[LAEventsXMLParser alloc] initWithData: xmlData delegate: self];
        [xmlParser parse];
    }
    return self;
}

- (void) parser: (LAEventsXMLParser *) parser foundEvent: (LAEvent *) event {
    [events addObject: event];
}

- (void) parserDidEndDocument:(LAEventsXMLParser *)parser {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"LAEventDatabaseUpdated" object: self];
}

- (NSArray *) uniqueDays {
    
    if (cachedUniqueDays != nil) {
        return cachedUniqueDays;
    }
    
    NSEnumerator *eventsEnumerator = [events objectEnumerator];
    LAEvent *currentEvent;
    
    NSMutableArray *uniqueDays = [[NSMutableArray alloc] init];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    while (currentEvent = [eventsEnumerator nextObject]) {
        NSDateComponents *currentEventDateComponents = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: [currentEvent startDate]];
        
        // In case there is no unique day yet we just add it straight away
        if ([uniqueDays count] == 0) {
            [currentEventDateComponents setSecond: 0];
            [currentEventDateComponents setMinute: 0];
            [currentEventDateComponents setHour: 0];
            
            [uniqueDays addObject: [calendar dateFromComponents: currentEventDateComponents]];
        }
        
        NSEnumerator *uniqueDaysEnumerator = [uniqueDays objectEnumerator];
        NSDate *currentUniqueDay;
        
        while (currentUniqueDay = [uniqueDaysEnumerator nextObject]) {
            NSDateComponents *uniqueDayDateComponents = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: currentUniqueDay];
            if([uniqueDayDateComponents day] == [currentEventDateComponents day] && \
               [uniqueDayDateComponents month] == [currentEventDateComponents month] && \
               [uniqueDayDateComponents year] == [currentEventDateComponents year]) {
                // Same date - obviously (imagine Ali-G voice here...)
            }
            else {
                // Same shit, different day
                [currentEventDateComponents setSecond: 0];
                [currentEventDateComponents setMinute: 0];
                [currentEventDateComponents setHour: 0];
                
                [uniqueDays addObject: [calendar dateFromComponents: currentEventDateComponents]];
                // We have found that the event has a unique day - we no longer need to go through all the other unique days
                break;
            }
        }        
    }
    
    cachedUniqueDays = uniqueDays;
    return uniqueDays;
}

- (NSArray *) eventsOnDay: (NSDate *) dayDate {
    NSEnumerator *eventsEnumerator = [events objectEnumerator];
    LAEvent *currentEvent;
    
    NSMutableArray *eventsOnDay = [NSMutableArray array];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    while (currentEvent = [eventsEnumerator nextObject]) {
        NSDateComponents *currentEventDateComponents = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: [currentEvent startDate]];
        NSDateComponents *eventDateComponents = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: dayDate];
        
        if([eventDateComponents day] == [currentEventDateComponents day] && \
           [eventDateComponents month] == [currentEventDateComponents month] && \
           [eventDateComponents year] == [currentEventDateComponents year]) {
            // Obviously the event is on the same day
            [eventsOnDay addObject: currentEvent];
        }
    }    
    return eventsOnDay;
}

+ (NSString *) eventDatabaseLocation {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *cacheFileLocation = [cachesDirectory stringByAppendingPathComponent:@"fosdem_schedule.xml"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath: cacheFileLocation]) {
        return cacheFileLocation;
    }
    
    NSString *resourcesDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *resourceFileLocation = [resourcesDirectory stringByAppendingPathComponent:@"fosdem_schedule.xml"];
    return resourceFileLocation;
    
}

- (void) dealloc {
    [events release];
    [super dealloc];
}


@end
