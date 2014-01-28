/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Adam Ziolkowski <adam@adsized.com> and Leon Handreke <leon.handreke@gmail.com>
 * wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy us a beer in return.
 * ----------------------------------------------------------------------------
 */
#import "LADownload.h"


@implementation LADownload

@synthesize request, delegate, destination, receivedLength, totalLength, fileHandle;


- (LADownload *) initWithRequest: (NSURLRequest *) newRequest destination: (NSString *) newDestination delegate: (id) newDelegate {
    if ( self = [super init]) {
        [self setRequest: newRequest];
        [self setDelegate: newDelegate];
        [self setDestination: [newDestination stringByAppendingPathExtension:@"download"]];
        // Make sure the directory is there
        [[NSFileManager defaultManager] createDirectoryAtPath: [self destination] withIntermediateDirectories: YES attributes: nil error: nil];
    }
    
    return self;
}

- (double) progress {
    return receivedLength / totalLength;
}

- (void) start {
    connection = [NSURLConnection connectionWithRequest:[self request] delegate: self];
    [connection start];
    //NSLog(@"Starting DL %@", connection);
}

- (void) cancel {
    [connection cancel];
    [fileHandle closeFile];
    [[NSFileManager defaultManager] removeItemAtPath: [self destination] error: nil];
}


#pragma mark  NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //DebugLog([self destination]);
    if( [manager fileExistsAtPath: [self destination]] )
    {
        [manager removeItemAtPath:[self destination] error:nil];
    }
    [manager createFileAtPath: [self destination] contents:nil attributes:nil];
    fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self destination]];
    
    downloadedData = [[NSMutableData alloc] init];
    
    totalLength = [response expectedContentLength];
    receivedLength = 0;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"REceived Data");
    //DebugLog(@"Received Data of length %d from connection", [data length]);
    [downloadedData appendData:data];
    receivedLength += data.length;
    //NSTimeInterval elapsedTime = -[startTime timeIntervalSinceNow];
    
    if( [delegate respondsToSelector:@selector(download:didReceiveDataOfLength:)] )
    {
        [delegate download: self didReceiveDataOfLength: data.length];
    }
    //can't keep too much data in memory. Write it to disk to avoid getting low memory error.
    if( downloadedData.length > 1048576 && fileHandle != nil )
    {
        [fileHandle writeData: downloadedData];
        
        downloadedData = [[NSMutableData alloc] init];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [fileHandle writeData: downloadedData];
    downloadedData = nil;
    
    NSString *newDestination = [[self destination] stringByDeletingPathExtension];
    // Delete the old file in case it's still there
    [[NSFileManager defaultManager] removeItemAtPath: newDestination error: nil];
    
    //Move the file to it's 'complete' location
    [[NSFileManager defaultManager] moveItemAtPath: [self destination] toPath: newDestination error: nil];
    
    if( [delegate respondsToSelector:@selector(downloadDidFinish:)] )
    {
        [delegate downloadDidFinish: self];
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", [error userInfo]);
}

@end
