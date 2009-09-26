//
//  LHLecture.h
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LHLecture : NSObject {

    NSString *title;
    NSString *speaker;
    
    NSString *descriptionPage;
    
    NSDate *startDate;
    NSTimeInterval duration;
}

@property (copy) NSString *title;
@property (copy) NSString *speaker;
@property (copy) NSString *descriptionPage;
@property (copy) NSDate *startDate;
@property (assign) NSTimeInterval duration;


@end
