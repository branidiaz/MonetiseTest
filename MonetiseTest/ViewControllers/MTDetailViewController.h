//
//  MTDetailViewController.h
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 03/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTContact.h"

@interface MTDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textViewNotes;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) MTContact *contact;

@end
