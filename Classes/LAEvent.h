//
//  LAEvent.h
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LAEvent : NSObject {

    NSString *identifier;
    
    NSString *title;
    NSString *subtitle;
    NSString *speaker;
    
    NSString *room;
    NSString *track;
    NSString *type;
    
    NSString *contentAbstract;
    NSString *contentDescription;
    
    NSDate *startDate;
    NSDate *endDate;
    
    BOOL starred;
}

//- (NSMutableDictionary *) userData;

@property (retain) NSString *identifier;
@property (retain) NSString *title;
@property (retain) NSString *subtitle;
@property (retain) NSString *speaker;
@property (retain) NSString *room;
@property (retain) NSString *track;
@property (retain) NSString *type;
@property (retain) NSString *contentAbstract;
@property (retain) NSString *contentDescription;

@property (retain) NSDate *startDate;
@property (retain) NSDate *endDate;

@property (assign) BOOL starred;


@end
