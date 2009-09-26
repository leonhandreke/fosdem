//
//  LALecturesDatabase.h
//  fosdem
//
//  Created by Leon on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LALecture.h"

@interface LALecturesDatabase : NSObject {

    NSMutableArray *lectures;
}

+ (NSString *) lecturesDatabaseLocation;
+ (LALecturesDatabase *) sharedLecturesDatabase;

- (LALecturesDatabase*) initWithDictionary: (NSDictionary *) dictionary;

@property (assign) NSMutableArray *lectures;
@end
