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

@property (copy) NSString *identifier;
@property (copy) NSString *title;
@property (copy) NSString *subtitle;
@property (copy) NSString *speaker;
@property (copy) NSString *room;
@property (copy) NSString *track;
@property (copy) NSString *type;
@property (copy) NSString *contentAbstract;
@property (copy) NSString *contentDescription;

@property (copy) NSDate *startDate;
@property (copy) NSDate *endDate;


@end
