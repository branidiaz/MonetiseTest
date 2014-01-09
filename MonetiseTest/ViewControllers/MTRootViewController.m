//
//  MTRootViewController.m
//  MonetiseTest
//
//  Created by Abraham Tomás Díaz Abreu on 03/08/13.
//  Copyright (c) 2013 Abraham Tomás Díaz Abreu. All rights reserved.
//

#import "MTRootViewController.h"
#import "MTContact.h"
#import "MTContactCell.h"
#import "MTDetailViewController.h"

@interface MTRootViewController ()

@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation MTRootViewController

static NSString * const kContactsURL = @"http://demo.monitise.net/download/tests/Data.xml";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.contacts = [[NSMutableArray alloc] init];
        
        MTDataDownloadOperation *dataDownloadOperation = [[MTDataDownloadOperation alloc] initWithProtocol:self withURL:kContactsURL];
        [[MTDownloaderManager sharedInstance] download:dataDownloadOperation];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:NSLocalizedString(@"RootViewController::Title", nil)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.contacts count] == 0)
        return 1;
    else
        return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ([self.contacts count] == 0)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
        [cell.textLabel setText:NSLocalizedString(@"RootViewController::Cell::Downloading", nil)];
        [cell setUserInteractionEnabled:NO];
    }
    else
    {
        MTContact *contact = [self.contacts objectAtIndex:indexPath.row];
        
        if (!contact.image)
        {
            if (contact.downloadState == NOT_DOWNLOADED)
            {
                MTImageDownloadOperation *operation = [[MTImageDownloadOperation alloc] initWithProtocol:self withURL:contact.imageURL withIndex:indexPath.row];
                [[MTDownloaderManager sharedInstance] download:operation];
            }
        }
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"MTContactCell"];
        if (cell == nil)
        {
            NSArray *cellBundle = [[NSBundle mainBundle] loadNibNamed:@"MTContactCell" owner:self options:nil];
            cell = [cellBundle objectAtIndex:0];
        }
        
        [(MTContactCell*)cell fillWithContact:contact];
    }
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTDetailViewController *detailVC = [[MTDetailViewController alloc] initWithNibName:@"MTDetailViewController" bundle:nil];
    [detailVC setContact:[self.contacts objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MTDataDownloadOperationDelegate

- (void)dataDownloaded:(NSData *)data
{
    MTContactsParserOperation *contactsParserOperation = [[MTContactsParserOperation alloc] initWithProtocol:self withData:data];
    [[MTParserManager sharedInstance] parseXML:contactsParserOperation];
}

- (void)downloadFailed
{
    
}

#pragma mark - MTImageDownloadOperationDelegate

-(void)imageDownloaded:(UIImage*)image forIndex:(NSInteger)index
{
    MTContact *contact = [self.contacts objectAtIndex:index];
    [contact setImage:image];
    [contact setDownloadState:DOWNLOADED];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

-(void)imageFailed
{
    //TODO
}

#pragma mark - MTContactsParserOperationDelegate

-(void)contactsParsed:(NSMutableArray*)contacts
{
    
    [self.tableView beginUpdates];
    
    if (self.contacts.count == 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    NSInteger startingRow = [self.contacts count];
    NSInteger contactsCount = [contacts count];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:contactsCount];
    
    for (NSInteger row = startingRow; row < (startingRow + contactsCount); row++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [indexPaths addObject:indexPath];
    }
    
    [self.contacts addObjectsFromArray:contacts];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
}

-(void)parseFailed:(NSError*)error
{
    //TODO
}


@end
