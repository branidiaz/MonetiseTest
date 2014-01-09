//
//  MTDownloaderManager.h
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 20/03/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTImageDownloadOperation.h"

@interface MTDownloaderManager : NSObject
{
    NSOperationQueue *downloadQueue;
}

- (void)download:(NSOperation*)operation;

+ (MTDownloaderManager*) sharedInstance;

@end
