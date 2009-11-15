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
    
    //Caching CPU-intensive operations
    NSArray *cachedUniqueDays;
	NSMutableDictionary *eventsOnDayCache;
    NSArray *tracksCache;
}

+ (NSString *) eventDatabaseLocation;
+ (LAEventDatabase *) sharedEventsDatabase;

//- (LAEventDatabase*) initWithDictionary: (NSDictionary *) dictionary;

- (LAEventDatabase *) initWithData: (NSData *) xmlData;
- (void) parser: (LAEventsXMLParser *) parser foundEvent: (LAEvent *) event;
- (void) parserFinishedParsing:(LAEventsXMLParser *)parser;

- (NSArray *) uniqueDays;
- (NSArray *) eventsOnDay: (NSDate *) dayDate;

-(NSArray *) tracks;
-(NSArray *) eventsForTrack: (NSString*) trackName;

@property (copy) NSMutableArray *events;

@end
