//
//  LAEventsXMLParser.h
//  fosdem
//
//  Created by Leon on 10/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LAEvent.h"

@interface LAEventsXMLParser : NSObject {
    id delegate;
    NSXMLParser *eventsXMLParser;
    
    NSString *currentDayString;
    NSMutableString *currentStringValue;
    LAEvent *currentEvent;
}

- (LAEventsXMLParser *) initWithData: (NSData *) xmlData delegate: (id) newDelegate;
- (BOOL) parse;

@property (assign) id delegate;
@end


// The delegate interface
@interface NSObject (LAEventsXMLParser)

- (void) parser: (LAEventsXMLParser *) parser foundEvent: (LAEvent *) event;
- (void) parserFinishedParsing:(LAEventsXMLParser *)parser;
@end