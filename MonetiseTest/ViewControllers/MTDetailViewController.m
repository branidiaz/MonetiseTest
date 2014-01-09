//
//  MTDetailViewController.m
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 03/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import "MTDetailViewController.h"

@interface MTDetailViewController ()

@end

@implementation MTDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:NSLocalizedString(@"DetailViewController::Title", nil)];
    [self.contact addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    
    if(self.contact.image)
        [self.imageView setImage:self.contact.image];
    else
        [self.activityIndicator startAnimating];
    
    
    [self.textViewNotes setText:self.contact.notes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"image"]) {
        if (self.contact.image)
        {
            [self.imageView setImage:self.contact.image];
            if ([self.activityIndicator isAnimating])
                [self.activityIndicator stopAnimating];
        }
    }
}


- (void)dealloc
{
    [self.contact removeObserver:self forKeyPath:@"image"];
}

@end
