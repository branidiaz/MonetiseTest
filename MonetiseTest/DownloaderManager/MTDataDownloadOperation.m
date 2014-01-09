//
//  MTDataDownloadOperation.m
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 04/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import "MTDataDownloadOperation.h"

@interface MTDataDownloadOperation ()
{
    BOOL executing;
    BOOL finished;
}
@end

@implementation MTDataDownloadOperation

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (id) initWithProtocol:(NSObject<MTDataDownloadOperationDelegate>*)protocolParam withURL:(NSString*)urlParam
{
    if (self = [super init])
    {
        self.protocol = protocolParam;
        self.url = urlParam;
        
        executing = NO;
        finished = NO;
    }
    return self;
}

- (void)start {
    
    if (![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:@selector(start)
                               withObject:nil waitUntilDone:NO];
        return;
    }
    
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    fileData = [[NSMutableData alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    if(!connection)
    {
        [self.protocol downloadFailed];
        [self completeOperation];
    }
}

#pragma mark NSURLConnection Delegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.protocol downloadFailed];
    [self completeOperation];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if([response respondsToSelector:@selector(statusCode)])
    {
        int statusCode = [((NSHTTPURLResponse *)response) statusCode];
        if (statusCode >= 400)
        {
            [connection cancel];
            [self.protocol downloadFailed];
            
            [self completeOperation];
        }
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [fileData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if(fileData == nil)
    {
        [self.protocol downloadFailed];
    }
    else
    {
        [self.protocol dataDownloaded:fileData];
    }
    
    [self completeOperation];
}


@end