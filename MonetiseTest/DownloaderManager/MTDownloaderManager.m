//
//  MTDownloaderManager.m
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 20/03/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import "MTDownloaderManager.h"

@implementation MTDownloaderManager

- (id)init {
    if(self = [super init]) {
        downloadQueue = [[NSOperationQueue alloc] init];
        downloadQueue.maxConcurrentOperationCount = 2;
    }
    
    return self;
}

- (void)download:(NSOperation*)operation
{
    [downloadQueue addOperation:operation];
}

#pragma mark - Singleton

static MTDownloaderManager *sharedCLDelegate = nil;

+ (MTDownloaderManager *) sharedInstance {
    @synchronized(self) {
        if(!sharedCLDelegate) {
            sharedCLDelegate = [[MTDownloaderManager alloc] init];
        }
    }
    
    return sharedCLDelegate;
}

@end
