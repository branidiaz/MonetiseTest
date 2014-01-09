//
//  MTContactsParserOperation.m
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 04/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import "MTContactsParserOperation.h"


@interface MTContactsParserOperation ()

@property (nonatomic, strong) NSMutableArray *currentContacts;
@property (nonatomic, strong) MTContact *currentContact;
@property (nonatomic, strong) NSMutableString *currentParsedCharacterData;

@property (nonatomic) BOOL accumulatingParsedCharacterData;

@end

@implementation MTContactsParserOperation

- (id) initWithProtocol:(NSObject<MTContactsParserOperationDelegate>*)protocolParam withData:(NSData*)data
{
    if (self = [super init])
    {
        self.protocol = protocolParam;
        self.dataContacts = data;
        
        self.currentContacts = [[NSMutableArray alloc] init];
        self.currentParsedCharacterData = [[NSMutableString alloc] init];
    }
    return self;
}

- (void) main
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.dataContacts];
    [parser setDelegate:self];
    [parser parse];
}

#pragma mark - Parser constants

static const NSUInteger kMaximumNumberOfEarthquakesToParse = 50;

static NSUInteger const kSizeOfContactsBatch = 2;

static NSString * const kContacts = @"contacts";
static NSString * const kContact = @"contact";
static NSString * const kFirstName = @"firstName";
static NSString * const kLastName = @"lastName";
static NSString * const kAge = @"age";
static NSString * const kSex = @"sex";
static NSString * const kPicture = @"picture";
static NSString * const kNotes = @"notes";

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    

    if ([elementName isEqualToString:kContact]) {
        MTContact *contact = [[MTContact alloc] init];
        self.currentContact = contact;
    }
    else if ([elementName isEqualToString:kFirstName] ||
             [elementName isEqualToString:kLastName] ||
             [elementName isEqualToString:kAge] ||
             [elementName isEqualToString:kSex] ||
             [elementName isEqualToString:kPicture] ||
             [elementName isEqualToString:kNotes]) {

        self.accumulatingParsedCharacterData = YES;
        self.currentParsedCharacterData = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:kContact]) {
        
        [self.currentContacts addObject:self.currentContact];

        if ([self.currentContacts count] >= kSizeOfContactsBatch) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.protocol contactsParsed:self.currentContacts];
            });
            self.currentContacts = [NSMutableArray array];
        }
    }
    else if ([elementName isEqualToString:kFirstName]) {
        [self.currentContact setFirstName:self.currentParsedCharacterData];
    }
    else if ([elementName isEqualToString:kLastName]) {
        [self.currentContact setLastName:self.currentParsedCharacterData];
    }
    else if ([elementName isEqualToString:kLastName]) {
        [self.currentContact setLastName:self.currentParsedCharacterData];
    }
    else if ([elementName isEqualToString:kAge]) {
        [self.currentContact setAge:[self.currentParsedCharacterData intValue]];
    }
    else if ([elementName isEqualToString:kSex]) {
        [self.currentContact setSex:self.currentParsedCharacterData];
    }
    else if ([elementName isEqualToString:kPicture]) {
        [self.currentContact setImageURL:self.currentParsedCharacterData];
    }
    else if ([elementName isEqualToString:kNotes]) {
        [self.currentContact setNotes:self.currentParsedCharacterData];
    }
    //We send the last ones
    else if ([elementName isEqualToString:kContacts]) {
        if ([self.currentContacts count] >= kSizeOfContactsBatch) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.protocol contactsParsed:self.currentContacts];
            });
            self.currentContacts = [NSMutableArray array];
        }
    }
    
    // Stop accumulating parsed character data
    self.accumulatingParsedCharacterData = NO;
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    //If accumulating
    if (self.accumulatingParsedCharacterData) {
        [self.currentParsedCharacterData appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.protocol parseFailed:parseError];
    });
}


@end
