/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

#import "LAEventsXMLParser.h"


@implementation LAEventsXMLParser

@synthesize delegate;
@synthesize eventsXMLParser;

- (LAEventsXMLParser *) initWithContentsOfFile: (NSString *) path delegate: (id) newDelegate {
    if (self = [super init]) {
        [self setDelegate: newDelegate];
		
        eventsXMLParser = [[NSXMLParser alloc] initWithContentsOfURL: [NSURL fileURLWithPath: path]];
        [eventsXMLParser setDelegate: self];
		
		dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss vvvv"];
		
    }
    
    return self;
}

- (BOOL) parse {
    return [eventsXMLParser parse];
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentStringValue) {
        // currentStringValue is an NSMutableString instance variable
        currentStringValue = [[NSMutableString alloc] init];
    }
    [currentStringValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString: @"vevent"]) {
		currentEvent = [[LAEvent alloc] init];
       // [currentEvent setIdentifier: [attributeDict objectForKey: @"pentabarf:event-id"]];
    }
    
	if ([elementName isEqualToString: @"pentabarf:event-id"] || [elementName isEqualToString: @"pentabarf:start"] || [elementName isEqualToString: @"pentabarf:end"] || [elementName isEqualToString: @"pentabarf:title"] || [elementName isEqualToString: @"location"] ||
		[elementName isEqualToString: @"pentabarf:subtitle"] || [elementName isEqualToString: @"abstract"] ||
		[elementName isEqualToString: @"pentabarf:track"] || [elementName isEqualToString: @"type"] ||
		[elementName isEqualToString: @"description"] || [elementName isEqualToString: @"attendee"]) {
	 
		[currentStringValue setString: @""];
	
	}
	
   /* if ([elementName isEqualToString: @"start"] || [elementName isEqualToString: @"duration"] || 
        [elementName isEqualToString: @"room"] || [elementName isEqualToString: @"title"] ||
        [elementName isEqualToString: @"subtitle"] || [elementName isEqualToString: @"track"] ||
        [elementName isEqualToString: @"type"] || [elementName isEqualToString: @"abstract"] ||
        [elementName isEqualToString: @"description"] || [elementName isEqualToString: @"person"]) {
        [currentStringValue setString: @""];
    }*/
    
    
}
                                        
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

	if ([elementName isEqualToString: @"pentabarf:event-id"]) {
		[currentEvent setIdentifier: [NSString stringWithString: currentStringValue]];
	}
	
	if ([elementName isEqualToString: @"pentabarf:start"]) {
        NSDate *eventStartDate = [dateFormatter dateFromString: currentStringValue];
        [currentEvent setStartDate: eventStartDate];
    }
	
	if ([elementName isEqualToString: @"pentabarf:end"]) {
        NSDate *eventEndDate = [dateFormatter dateFromString: currentStringValue];
		[currentEvent setEndDate: eventEndDate];
    }
	
	if ([elementName isEqualToString: @"pentabarf:title"]) {
        [currentEvent setTitle: [NSString stringWithString: currentStringValue]];
    }
	
	if ([elementName isEqualToString: @"location"]) {
        [currentEvent setLocation: [NSString stringWithString: currentStringValue]];
    }
	
	if ([elementName isEqualToString: @"pentabarf:subtitle"]) {
        [currentEvent setSubtitle: [NSString stringWithString: currentStringValue]];
    }
    
	if ([elementName isEqualToString: @"pentabarf:track"]) {
		[currentEvent setTrack: [NSString stringWithString: currentStringValue]];
    }
	
	// Currently there dosn't seem to be an abstract object
	if ([elementName isEqualToString: @"abstract"]) {
        //[currentEvent setContentAbstract: [NSString stringWithString: currentStringValue]];
    }
	
	// Currently there dosn't seem to be a type object returning emtpy string atm
	if ([elementName isEqualToString: @"type"]) {
        //[currentEvent setType: [NSString stringWithString: currentStringValue]];
		[currentEvent setType: @""];
    }
	
	if ([elementName isEqualToString: @"description"]) {
        [currentEvent setContentDescription: [NSString stringWithString: currentStringValue]];
    }
	
    if ([elementName isEqualToString: @"attendee"]) {
        [currentEvent setSpeaker: [NSString stringWithString: currentStringValue]];
    }
	
	if ([elementName isEqualToString: @"vevent"]) {
        [delegate parser: self foundEvent: currentEvent];
    }
    
    if ([elementName isEqualToString: @"iCalendar"]) {
        [delegate parserDidFinishSchedule: self];
    }

}

- (void)parserDidEndDocument:(NSXMLParser *)parser {

    [delegate parserFinishedParsing: self];

}

@end
