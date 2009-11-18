//
//  LAEvent.m
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LAEvent.h"
#import "LAEventDatabase.h"


@implementation LAEvent

@synthesize identifier, title, subtitle, speaker, room, track, type, contentAbstract, contentDescription, startDate, endDate, starred;

- (LAEvent *)init {
    if (self = [super init]) {
        [self setIdentifier: @""];
        [self setTitle: @""];
        [self setSubtitle: @""];
        [self setSpeaker: @""];
        [self setTrack: @""];
        [self setContentAbstract: @""];
        [self setContentDescription: @""];
        [self setStartDate: [NSDate date]];
        [self setEndDate: [NSDate date]];
        [self setStarred: NO];
		[[NSNotificationCenter defaultCenter] addObserver: self 
												 selector: @selector(updateWithUserData:) 
													 name: @"LAEventUserDataUpdated"  
												   object: nil];
    }
    return self;
}

- (NSMutableDictionary *) userData {
	return [[LAEventDatabase sharedEventsDatabase] userDataForEventWithIdentifier: [self identifier]];
}


- (void) setStarred:(BOOL) isStarred {
	[[self userData] setObject: [NSNumber numberWithBool: isStarred] forKey: @"starred"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LAEventUserDataUpdated" 
														object: self 
													  userInfo: [NSDictionary dictionaryWithObjectsAndKeys: identifier, @"eventIdentifier"]];
}

- (void) updateWithUserData {
	[self setStarred: [(NSNumber *)[[self userData] objectForKey: @"starred"] boolValue]];
}

/*
- (LAEvent *) initWithDictionary: (NSDictionary *) dictionary {
    if (self = [self init]) {
        [self setTitle: [dictionary valueForKey: @"title"]];
        [self setSpeaker: [dictionary valueForKey: @"speaker"]];
        [self setTrack: [dictionary valueForKey: @"track"]];
        [self setDescriptionPage: [dictionary valueForKey: @"descriptionPage"]];
        [self setStartDate: [dictionary valueForKey: @"startDate"]];
        [self setEndDate: [dictionary valueForKey: @"endDate"]];
    }
    return self;
}*/
@end
