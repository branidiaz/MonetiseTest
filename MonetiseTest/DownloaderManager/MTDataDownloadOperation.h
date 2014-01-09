//
//  MTDataDownloadOperation.h
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 04/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTDataDownloadOperationDelegate <NSObject>
-(void)dataDownloaded:(NSData*)data;
-(void)downloadFailed;
@end

@interface MTDataDownloadOperation : NSOperation <NSURLConnectionDelegate>
{
    NSMutableData *fileData;
}

@property (nonatomic, strong) NSObject<MTDataDownloadOperationDelegate>* protocol;
@property (nonatomic, strong) NSString *url;

- (id) initWithProtocol:(NSObject<MTDataDownloadOperationDelegate>*)protocolParam withURL:(NSString*)url;

@end
