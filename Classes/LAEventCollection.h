//
//  LAEventCollection.h
//  fosdem
//
//  Created by Adam Ziolkowski on 26/12/2012.
//
//

#import <Foundation/Foundation.h>

@class LAEvent;

@interface LAEventCollection : NSObject

-(id) init;
-(void) addEvent: (LAEvent*) newEvent;
-(void) addEvents: (NSArray*) newEvents;

@property (nonatomic, assign) NSMutableArray *events;
@property (nonatomic, assign) NSMutableArray *uniqueDays;
@property (nonatomic, assign) NSMutableDictionary *eventsOnDay;

@end
