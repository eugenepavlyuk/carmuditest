//
//  CatalogModel.m
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 08/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import "CatalogModel.h"
#import "ConnectionManager.h"
#import "ItemParser.h"
#import "Item.h"
#import <NSManagedObject+MagicalFinders.h>
#import <NSManagedObject+MagicalRecord.h>
#import <MagicalRecord+Actions.h>

@implementation CatalogModel
{
    NSDate *lastUpdatedDate;
    NSInteger currentPage;
    NSMutableArray *objects;
}

@synthesize objects;

- (id)init
{
    self = [super init];
        
    if(self)
    {
        currentPage = 1;
        objects = [NSMutableArray array];
        self.reloading = YES;
        [self resetModel];
        
        NSMutableArray *items = [[Item MR_findAll] mutableCopy];
                
        [self.objects addObjectsFromArray:items];
    }
    
    return self;
}

- (BOOL)isLoading
{
    return isLoading;
}

- (BOOL)canLoadMore
{
    return ([self.objects count]);
}

- (BOOL)didLoadFirstPage
{
    return (![self isLoading] && [self.objects count]/* <= [pager[kItemOffsetKey] intValue]*/);
}

- (NSDate*)lastUpdatedDate
{
    return lastUpdatedDate;
}

- (void)resetModel
{
    [objects removeAllObjects];
    
    currentPage = 1;
}

/**
 *  Method for fetching data from the server
 *
 *  @param info       Dictionary with parameters
 *  @param completion block for completion handling
 *  @param failure    block for failure handling
 */
- (void)loadItemsWithInfo:(NSDictionary*)info
          completionBlock:(modelCompletionBlock)completionBlock
             failureBlock:(modelFailureBlock)failureBlock
{
    isLoading = YES;
    
    NSMutableDictionary *parameters = [info mutableCopy];
    
    [parameters setObject:[NSString stringWithFormat:@"%i", currentPage] forKey:kPageKey];

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[ConnectionManager sharedInstance] loadItemsWithInfo:parameters
                                          completionBlock:^(id object) {
        
        isLoading = NO;
                           
        ItemParser *feedParser = [[ItemParser alloc] init];

        [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext){
          
          if (self.reloading)
          {
              [Item MR_truncateAll];
          }
          
          [feedParser parseResponse:object];
          
        } completion:^(BOOL bSuccess, NSError *error){
          
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
          if (self.reloading)
          {
              [self resetModel];
              
              self.reloading = NO;
          }
          
          if (feedParser.success)
          {
              currentPage++;
              
              [self.objects removeAllObjects];
              NSMutableArray *items = [[Item MR_findAll] mutableCopy];
              
              [self.objects addObjectsFromArray:items];
              
              if (completionBlock)
              {
                  completionBlock();
              }
              else
              {
                  failureBlock();
              }
          }
          else
          {
              failureBlock();
          }
          
        }];
                                    
    } failureBlock:^{
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        isLoading = NO;
        
        if (failureBlock)
        {
            failureBlock();
        }
    }];
}

@end
