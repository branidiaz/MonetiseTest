//
//  MTContactCell.m
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 03/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import "MTContactCell.h"
#import "MTDownloaderManager.h"
#import "MTImageDownloadOperation.h"

@implementation MTContactCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.labelNameTitle setText:NSLocalizedString(@"MTContactCell::NameTitle", nil)];
    [self.labelLastNameTitle setText:NSLocalizedString(@"MTContactCell::LastNameTitle", nil)];
    [self.labelSexTitle setText:NSLocalizedString(@"MTContactCell::SexTitle", nil)];
    [self.labelAgeTitle setText:NSLocalizedString(@"MTContactCell::AgeTitle", nil)];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillWithContact:(MTContact*)contact
{
    [self.labelName setText:contact.firstName];
    [self.labelLastName setText:contact.lastName];
    [self.labelSex setText:contact.sex];
    [self.labelAge setText:[NSString stringWithFormat:@"%d",contact.age]];
    
    if (contact.image)
    {
        [self.image setImage:contact.image];
        [self.activityIndicator stopAnimating];
    }
    else
    {
        [self.activityIndicator startAnimating];
    }
    
}

@end
