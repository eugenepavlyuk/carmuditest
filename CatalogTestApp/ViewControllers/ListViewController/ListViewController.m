//
//  ListViewController.m
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 08/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import "ListViewController.h"
#import "SVPullToRefresh.h"
#import "CatalogModel.h"
#import <MBProgressHUD.h>
#import "ItemTableViewCell.h"

@interface ListViewController ()

@property (nonatomic, weak) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) CatalogModel *catalogModel;

@end

@implementation ListViewController
{
    CatalogModel *catalogModel;
}

@synthesize catalogModel;

/**
 *  Designed initializer for controller
 *
 *  @param aDecoder decoder class
 *
 *  @return id - the instance of the view controller
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.catalogModel = [[CatalogModel alloc] init];
    }
    
    return self;
}

/**
 *  method for fetching data from the server
 */
- (void)loadItems
{
    if (![self.catalogModel isLoading])
    {
        __weak ListViewController *weakSelf = self;
        
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        
        switch (segmentControl.selectedSegmentIndex) {
            case 0:
                [info setObject:@"popularity" forKey:kSortKey];
                break;
                
            case 1:
                [info setObject:@"name" forKey:kSortKey];
                break;
                
            case 2:
                [info setObject:@"price" forKey:kSortKey];
                break;
                
            case 3:
                [info setObject:@"brand" forKey:kSortKey];
                break;
                
            default:
                break;
        }
        
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self.catalogModel loadItemsWithInfo:info
                              completionBlock:^{
                                  
                                  [weakSelf updateUI];
                                  
                                  self.mainTableView.showsInfiniteScrolling = ([self.catalogModel.objects count] > 0);
                                  
                                  //[MBProgressHUD hideHUDForView:self.view animated:YES];
                                  
                              } failureBlock:^{
                                  
                                  [weakSelf updateUI];
                                  
                                  //[MBProgressHUD hideHUDForView:self.view animated:YES];
                                  
                              }];
    }
}

/**
 *  this method is called every time when user selects type of sorting
 *
 *  @param sender sender of the event (UISegmentControl for sorting)
 */
- (IBAction)segmentControlValueChanged:(UISegmentedControl*)sender
{
    self.catalogModel.reloading = YES;
    [self loadItems];
}

/**
 *  This method is called when the main view of ViewController is loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Catalog";
    
    __weak ListViewController *weakSelf = self;
        
    [self.mainTableView addPullToRefreshWithActionHandler:^{
        weakSelf.catalogModel.reloading = YES;
        [weakSelf loadItems];
    }];
    
    [self.mainTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadItems];
    }];
    
    self.mainTableView.showsInfiniteScrolling = ([self.catalogModel.objects count] > 0);
    
    [self loadItems];
}

/**
 *  Update UI after fetching
 */
- (void)updateUI
{
    [self.mainTableView reloadData];
    
    [self.mainTableView.pullToRefreshView stopAnimating];
    
//    self.mainTableView.pullToRefreshView.lastUpdatedDate = [NSDate date];
    
    if (self.mainTableView.showsInfiniteScrolling)
    {
        [self.mainTableView.infiniteScrollingView stopAnimating];
    }
    
    self.mainTableView.showsInfiniteScrolling = [self.catalogModel canLoadMore];
}

#pragma mark - UITableViewDataSource's methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.catalogModel.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemTableViewCell *itemTableViewCell = (ItemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[ItemTableViewCell cellIdentifier]];
        
    Item *item = self.catalogModel.objects[indexPath.row];
    
    [itemTableViewCell configureCellWithItem:item];
    
    return itemTableViewCell;
}

@end

