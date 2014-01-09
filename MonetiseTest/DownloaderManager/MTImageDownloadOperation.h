//
//  MTImageDownloadOperation.h
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 20/03/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTImageDownloadOperationDelegate <NSObject>
-(void)imageDownloaded:(UIImage*)image forIndex:(NSInteger)index;
-(void)imageFailed;
@end

@interface MTImageDownloadOperation : NSOperation <NSURLConnectionDelegate>
{
    NSMutableData *fileData;
}

@property (nonatomic, strong) NSObject<MTImageDownloadOperationDelegate>* protocol;
@property (nonatomic, strong) NSString *urlImage;
@property (nonatomic) NSInteger index;

- (id) initWithProtocol:(NSObject<MTImageDownloadOperationDelegate>*)protocolParam withURL:(NSString*)url withIndex:(NSInteger)index;

@end
