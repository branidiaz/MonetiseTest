//
//  MTContactsParserOperation.h
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 04/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTContact.h"

@protocol MTContactsParserOperationDelegate <NSObject>
-(void)contactsParsed:(NSMutableArray*)contacts;
-(void)parseFailed:(NSError*)error;
@end

@interface MTContactsParserOperation : NSOperation <NSXMLParserDelegate>

@property (nonatomic, strong) NSObject<MTContactsParserOperationDelegate>* protocol;
@property (nonatomic, strong) NSData *dataContacts;

- (id) initWithProtocol:(NSObject<MTContactsParserOperationDelegate>*)protocolParam withData:(NSData*)data;

@end
