//
//  MTContactCell.h
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 03/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTContact.h"

@interface MTContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *labelNameTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelLastNameTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelLastName;
@property (weak, nonatomic) IBOutlet UILabel *labelAgeTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelAge;
@property (weak, nonatomic) IBOutlet UILabel *labelSexTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSex;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)fillWithContact:(MTContact*)contact;

@end
