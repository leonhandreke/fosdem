//
//  LAEventDatabase.m
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LAEventDatabase.h"


@implementation LAEventDatabase


@synthesize events, eventsUserData;

static LAEventDatabase *mainEventDatabase = nil;

+ (LAEventDatabase *) sharedEventDatabase
{
	if(mainEventDatabase == nil) {
        //NSLog(@"Loading event DB");
        /*// Try to load from the resource bundle first
         NSDictionary *eventsDictionary = [NSDictionary dictionaryWithContentsOfFile: [self eventsDatabaseLocation]];*/
		//NSDictionary *eventsDictionary = [NSDictionary dictionaryWithContentsOfFile: [self eventDatabaseLocation]];                                                                                                                     
		mainEventDatabase = [[LAEventDatabase alloc] initWithContentsOfFile: [self eventDatabaseLocation]];
    }
    return mainEventDatabase;	
}


- (LAEventDatabase*) init {
    if (self = [super init]) {
        events = [[NSMutableArray alloc] init];
		//stared = [[NSMutableArray alloc] init];
        eventsOnDayCache = [[NSMutableDictionary alloc] init];
		
        [[NSNotificationCenter defaultCenter] addObserver: self 
												 selector: @selector(eventDatabaseUpdated:) 
													 name: @"LAEventDatabaseUpdated"  
												   object: nil];
    }
    return self;
}

- (LAEventDatabase *) initWithContentsOfFile: (NSString *) filePath {
    if (self = [self init]) {
        
        // Before the parsing because the userInfo dict is needed to set the properties
        NSMutableDictionary *userDataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile: [LAEventDatabase userDataFileLocation]];
        if (!userDataDictionary) {
            userDataDictionary = [[NSMutableDictionary alloc] init];
        }
        
		[self setEventsUserData: userDataDictionary];
        
        LAEventsXMLParser *xmlParser = [[LAEventsXMLParser alloc] initWithContentsOfFile: filePath delegate: self];
        [xmlParser parse];
        
        // After parsing because we don't want to rewrite what has just been read while parsing
        [[NSNotificationCenter defaultCenter] addObserver: self 
												 selector: @selector(eventUpdated:) 
													 name: @"LAEventUpdated"  
												   object: nil];
    }
    
    return self;
}

- (void) parser: (LAEventsXMLParser *) parser foundEvent: (LAEvent *) event {
    [events addObject: event];
    [self updateEventWithUserData: event];
}

- (void) parserFinishedParsing:(LAEventsXMLParser *)parser {
    [parser release];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"LAEventDatabaseUpdated" object: self];
	[events sortUsingSelector: @selector(compareDateWithEvent:)];
}

- (void) parserDidFinishSchedule:(LAEventsXMLParser *)parser {
    
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
        
        // We have the date of the event. Now we have to loop through the existing unique dates to see if there already is a date like that.
        NSEnumerator *uniqueDaysEnumerator = [uniqueDays objectEnumerator];
        NSDate *currentUniqueDay;
        
        BOOL foundMatchingDay = NO;
        
        while (currentUniqueDay = [uniqueDaysEnumerator nextObject]) {
            NSDateComponents *uniqueDayDateComponents = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: currentUniqueDay];
            // Does the current looped unique day match the one we have from the event?
            if([uniqueDayDateComponents day] == [currentEventDateComponents day] && \
               [uniqueDayDateComponents month] == [currentEventDateComponents month] && \
               [uniqueDayDateComponents year] == [currentEventDateComponents year]) {
                // Our event does not have a unique date
                foundMatchingDay = YES;
                break;
                
            }
        }
        
        // If the day was already in the uniqueDays, we would have found it by now
        if (!foundMatchingDay) {
            // The event day is unique! Let's insert it!
            // Same shit, different day
            [currentEventDateComponents setSecond: 0];
            [currentEventDateComponents setMinute: 0];
            [currentEventDateComponents setHour: 0];
            
            [uniqueDays addObject: [calendar dateFromComponents: currentEventDateComponents]];
        }
    }
    
    cachedUniqueDays = uniqueDays;
    return uniqueDays;
}

- (NSArray *) eventsOnDay: (NSDate *) dayDate {
	
	// Not really the way to do it but it probably works fine
	if ([eventsOnDayCache objectForKey: dayDate] != nil) {
		return [eventsOnDayCache objectForKey: dayDate];
	}
	
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
	
	[eventsOnDayCache setObject: eventsOnDay forKey: dayDate];
	//NSLog(@"BOOM");
    return eventsOnDay;
}

-(NSArray *) tracks {
	
    if (tracksCache != nil) {
        return tracksCache;
    }
    
	NSEnumerator *eventsEnumerator = [events objectEnumerator];
    LAEvent *currentEvent;
    
    NSMutableArray *tracks = [[NSMutableArray alloc] init];
	
	while (currentEvent = [eventsEnumerator nextObject]){
        
		if (![tracks containsObject: [NSString stringWithFormat: @"%@", [currentEvent track]]]) {
			[tracks addObject: [NSString stringWithFormat: @"%@", [currentEvent track]]];
		}
        
	}
	
    tracksCache = tracks;
    
	return tracks;
}

- (NSMutableArray *) starredEvents {
    
    /*if (starredCache != nil) {
        return starredCache;
    }*/
    
	NSEnumerator *eventsEnumerator = [events objectEnumerator];
    LAEvent *currentEvent;
    
    NSMutableArray *starredEvents = [NSMutableArray array];
	
	while (currentEvent = [eventsEnumerator nextObject]){
        
		if ([currentEvent isStarred]) {
            [starredEvents addObject: currentEvent];        
        }
	}
	
    //starredCache = starredEvents;
    
	return starredEvents;
    
}

-(NSArray *) eventsForTrack: (NSString*) trackName {
	
	NSEnumerator *eventsEnumerator = [events objectEnumerator];
    LAEvent *currentEvent;
    
    NSMutableArray *eventsForTrackName = [NSMutableArray array];
	
	while (currentEvent = [eventsEnumerator nextObject]){
		
		if ([[currentEvent track] isEqualToString: trackName]) {
			[eventsForTrackName addObject: currentEvent];
		}
		
	}
    
	return eventsForTrackName;
	
}

+ (NSString *) eventDatabaseLocation {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *cacheFileLocation = [cachesDirectory stringByAppendingPathComponent:@"fosdem_schedule.xcal"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath: cacheFileLocation]) {
        return cacheFileLocation;
    }
    
    NSString *resourcesDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *resourceFileLocation = [resourcesDirectory stringByAppendingPathComponent:@"fosdem_schedule.xcal"];
    return resourceFileLocation;
    
}


+ (NSString *) userDataFileLocation {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *userDataFileLocation = [documentDirectory stringByAppendingPathComponent:@"userData.plist"];
    
    return userDataFileLocation;
}


- (NSMutableDictionary *) userDataForEventWithIdentifier: (NSString *) identifier {
	if ([eventsUserData objectForKey: identifier] == nil) {
		[eventsUserData setObject: [NSMutableDictionary dictionary] forKey: identifier];
	}
	return [eventsUserData objectForKey: identifier];
}

- (void) eventUpdated: (NSNotification *) notification {
    NSDictionary *infoDict = [notification userInfo];
    NSMutableDictionary *userData = [self userDataForEventWithIdentifier: [infoDict objectForKey: @"identifier"]];
    
    if ([infoDict objectForKey: @"starred"]) {
        // Change in the starred property
        [userData setObject: [infoDict objectForKey: @"starred"] forKey: @"starred"];
    }
    
    [[NSFileManager defaultManager] createDirectoryAtPath: [[[self class] userDataFileLocation] stringByDeletingLastPathComponent] attributes: nil];
    [[self eventsUserData] writeToFile: [[self class] userDataFileLocation] atomically: NO];
}

- (void) updateEventWithUserData: (LAEvent *) event {
	
    NSMutableDictionary *userData = [self userDataForEventWithIdentifier: [event identifier]];
    if ([userData objectForKey: @"starred"]) {
        [event setStarred: [(NSNumber *)[userData objectForKey: @"starred"] boolValue]];
    }
}


- (void) eventDatabaseUpdated: (NSNotification *) notification {
    // Clear out all the caches
    [tracksCache release];
    tracksCache = nil;
    //[starredCache release];
    [cachedUniqueDays release];
    cachedUniqueDays = nil;
    [eventsOnDayCache release];
    eventsOnDayCache = nil;
    eventsOnDayCache = [[NSMutableDictionary alloc] init];
}

- (void) dealloc {
    [events release];
    [super dealloc];
}

@end
