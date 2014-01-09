//
//  MTParserManager.m
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 04/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import "MTParserManager.h"

@implementation MTParserManager

- (id)init {
    if(self = [super init]) {
        parserQueue = [[NSOperationQueue alloc] init];
        parserQueue.maxConcurrentOperationCount = 1;
    }
    
    return self;
}

- (void)parseXML:(NSOperation*)operation
{
    [parserQueue addOperation:operation];
}

#pragma mark - Singleton

static MTParserManager *sharedCLDelegate = nil;

+ (MTParserManager *) sharedInstance {
    @synchronized(self) {
        if(!sharedCLDelegate) {
            sharedCLDelegate = [[MTParserManager alloc] init];
        }
    }
    
    return sharedCLDelegate;
}

@end