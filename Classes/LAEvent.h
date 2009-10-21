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
}

@property (assign) NSString *identifier;
@property (assign) NSString *title;
@property (assign) NSString *subtitle;
@property (assign) NSString *speaker;
@property (assign) NSString *room;
@property (assign) NSString *track;
@property (assign) NSString *type;
@property (assign) NSString *contentAbstract;
@property (assign) NSString *contentDescription;

@property (assign) NSDate *startDate;
@property (assign) NSDate *endDate;


@end
