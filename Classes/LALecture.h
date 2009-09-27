//
//  LALecture.h
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LALecture : NSObject {

    NSString *uuid;
    
    NSString *title;
    NSString *speaker;
    
    NSString *track;
    
    NSString *descriptionPage;
    
    NSDate *startDate;
    NSDate *endDate;
}

@property (copy) NSString *title;
@property (copy) NSString *speaker;
@property (copy) NSString *track;
@property (copy) NSString *descriptionPage;
@property (copy) NSDate *startDate;
@property (copy) NSDate *endDate;


@end
