/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */

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
