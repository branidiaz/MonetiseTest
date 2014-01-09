//
//  MTRootViewController.h
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 03/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTImageDownloadOperation.h"
#import "MTDownloaderManager.h"
#import "MTParserManager.h"
#import "MTContactsParserOperation.h"
#import "MTDataDownloadOperation.h"

@interface MTRootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MTImageDownloadOperationDelegate, MTContactsParserOperationDelegate, MTDataDownloadOperationDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
