//
//  LAEvent.m
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LAEvent.h"


@implementation LAEvent

@synthesize identifier, title, subtitle, speaker, room, track, type, contentAbstract, contentDescription, startDate, endDate, starred;
/*
- (LAEvent *)init {
    if (self = [super init]) {
    }
    return self;
}*/
/*
- (NSMutableDictionary *) userData {
	return [[LAEventDatabase sharedEventDatabase] userDataForEventWithIdentifier: [self identifier]];
}*/


- (void) setStarred:(BOOL) isStarred {
    starred = isStarred;
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys: [self identifier], @"identifier", [NSNumber  numberWithBool: isStarred], @"starred", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"LAEventUpdated" 
                                                        object: self 
                                                      userInfo: infoDict];
}


@end
