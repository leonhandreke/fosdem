/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

#import "LAEventCollection.h"

#import "LAEvent.h"
#import "NSDate+Between.h"

@implementation LAEventCollection

@synthesize events;
@synthesize uniqueDays;
@synthesize eventsOnDay;

-(id) init {

    self = [super init];
    
    if (self){
    
        events = [[NSMutableArray alloc] init];
        uniqueDays = [[NSMutableArray alloc] init];
        eventsOnDay = [[NSMutableDictionary alloc] init];
    
    }
    
    return self;

}

-(void) addEvent: (LAEvent*) newEvent {
    
    // Check that the event has not already been added to the collection
    
    if (![events containsObject: newEvent]){

        // Get the rounded date for the new event
        
        NSDate *roundedDate = [[newEvent startDate] getRoundedDate];
        
        // Check wether there is already an event with the same date
        
        for (NSDate *date in uniqueDays){
        
            if (![roundedDate isEqualToDate: date]){
                
                // Add the date to the unique days
                
                [uniqueDays addObject: roundedDate];
                
                // Resort the unique days to ensure that the dates are in order
                
                [uniqueDays sortUsingSelector:@selector(compare:)];
            
            }
            
        }
        
        // If there are no unique days then add this one as the first
        
        if ([uniqueDays count] == 0){
            
            [uniqueDays addObject: roundedDate];
            
        }
        
        // Also associate the event to the correct day in the eventsOnDay dictionary
        
        [[eventsOnDay objectForKey: roundedDate] addObject: newEvent];
        
        // Keep the events in order
        
        [[eventsOnDay objectForKey: roundedDate] sortUsingSelector: @selector(compareDateWithEvent:)];
        
        // Add the event to the collection
        
        [events addObject: newEvent];
     
    }
    
}

-(void) addEvents: (NSArray*) newEvents {

    for (LAEvent *newEvent in newEvents){
    
        if (![events containsObject: newEvent]){
         
            // Get the rounded date for the new event
            
            NSDate *roundedDate = [[newEvent startDate] getRoundedDate];
            
            // Check wether there is already an event with the same date
            
            BOOL isUnique = TRUE;
            
            for (NSDate *date in uniqueDays){
                
                if ([roundedDate isEqualToDate: date]){
                    
                    isUnique = FALSE;
                    
                }
                
            }
            
            if (isUnique){
            
                [uniqueDays addObject: roundedDate];
                
                // Initialise an array for the events
                
                [eventsOnDay setObject: [[NSMutableArray alloc] init] forKey: roundedDate];
                
            }
            
            // Also associate the event to the correct day in the eventsOnDay dictionary
            
            [[eventsOnDay objectForKey: roundedDate] addObject: newEvent];
            
            // Add the event to the collection
            
            [events addObject: newEvent];
            
        }
    
    }
    
    // Perform the sorting once after all the events have been added
    
    [uniqueDays sortUsingSelector:@selector(compare:)];
    
    // Ensure all the events for each day are in order
    
    for (NSDate *uniqueDay in uniqueDays){
        
        [[eventsOnDay objectForKey: uniqueDay] sortUsingSelector: @selector(compareDateWithEvent:)];
    
    }
    

}

@end
