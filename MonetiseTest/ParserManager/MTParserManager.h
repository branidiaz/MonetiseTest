//
//  MTParserManager.h
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 04/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTParserManager : NSObject
{
    NSOperationQueue *parserQueue;
}

- (void)parseXML:(NSOperation*)operation;

+ (MTParserManager*) sharedInstance;

@end
