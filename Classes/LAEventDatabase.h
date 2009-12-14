//
//  LAEventDatabase.h
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

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

- (LAEventDatabase *) initWithData: (NSData *) xmlData;
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

// Clear out the caches
- (void) eventDatabaseUpdated: (NSNotification *) notification;

-(NSArray*) eventsTakingPlaceNow;
-(NSArray*) eventsWithSeconds: (int) seconds;

@property (retain) NSMutableArray *events;
@property (retain) NSMutableDictionary *eventsUserData;

@end
