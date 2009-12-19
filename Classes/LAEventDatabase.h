//
//  LAEventDatabase.h
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSDate+Between.h"

#import "LAEvent.h"
#import "LAEventsXMLParser.h"

@interface LAEventDatabase : NSObject {

    NSMutableArray *events;
	//NSMutableArray *stared;
    
	NSMutableDictionary *eventsUserData;
	
    //Caching CPU-intensive operations
    NSArray *cachedUniqueDays;
	NSMutableDictionary *eventsOnDayCache;
    NSArray *tracksCache;
    //NSArray *starredCache;
}

+ (NSString *) eventDatabaseLocation;
+ (NSString *) userDataFileLocation;

+ (LAEventDatabase *) sharedEventDatabase;

//- (LAEventDatabase*) initWithDictionary: (NSDictionary *) dictionary;

- (LAEventDatabase *) initWithContentsOfFile: (NSString *) filePath;
- (void) parser: (LAEventsXMLParser *) parser foundEvent: (LAEvent *) event;
- (void) parserFinishedParsing:(LAEventsXMLParser *)parser;

- (NSArray *) uniqueDays;
- (NSArray *) eventsOnDay: (NSDate *) dayDate;

- (NSArray *) tracks;
- (NSArray *) eventsForTrack: (NSString*) trackName;
- (NSMutableArray *) starredEvents;

- (NSMutableDictionary *) userDataForEventWithIdentifier: (NSString *) identifier;
- (void) eventUpdated: (NSNotification *) notification;
- (void) updateEventWithUserData: (LAEvent *) event;

- (NSArray *) eventsWhile:(NSDate *)whileDate;
- (NSArray *)eventsInTimeInterval:(NSTimeInterval) timeInterval afterDate:(NSDate *)startDate;

// Clear out the caches
- (void) eventDatabaseUpdated: (NSNotification *) notification;


@property (retain) NSMutableArray *events;
@property (retain) NSMutableDictionary *eventsUserData;

@end
