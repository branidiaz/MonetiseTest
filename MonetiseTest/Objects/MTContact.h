//
//  MTContact.h
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 03/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ContactImageDownloadState {
    NOT_DOWNLOADED = 0,
    DOWNLOADING = 1,
    DOWNLOADED = 2
};

@interface MTContact : NSObject

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic) int age;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *notes;

@property (nonatomic) enum ContactImageDownloadState downloadState;

@end
