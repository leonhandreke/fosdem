//
//  LADownload.h
//  fosdem
//
//  Created by Adam Ziolkowski on 20/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LADownload : NSObject {

	id delegate;
    NSURLRequest *request;
    NSString *destination;
    
    NSURLConnection *connection;
    NSFileHandle *fileHandle;
    double totalLength;
    
    NSMutableData *downloadedData;
    double receivedLength;
	
}

- (LADownload *) initWithRequest: (NSURLRequest *) newRequest destination: (NSString *) newDestination delegate: (id) newDelegate;

- (double) progress;

- (void) start;
- (void) cancel;


@property (readonly) double totalLength;
@property (assign) id delegate;
@property (retain) NSURLRequest *request;
@property (retain) NSString *destination;
@property (readonly) double receivedLength;

@end

// The delegate interface
@interface NSObject (LADownload)

- (void)downloadDidFinish: (LADownload *) download;
- (void)download: (LADownload *) download didReceiveDataOfLength: (NSUInteger) dataLength;
// etc...

@end
