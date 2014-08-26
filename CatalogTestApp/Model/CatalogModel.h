//
//  CatalogModel.h
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 08/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^modelCompletionBlock) ();
typedef void (^modelFailureBlock) ();

@interface CatalogModel : NSObject
{
    BOOL isLoading;
}

@property (nonatomic, readonly) NSMutableArray *objects;

@property (atomic, assign) BOOL reloading;

/**
 *  Method for fetching data from the server
 *
 *  @param info       Dictionary with parameters
 *  @param completion block for completion handling
 *  @param failure    block for failure handling
 */
- (void)loadItemsWithInfo:(NSDictionary*)info
          completionBlock:(modelCompletionBlock)completionBlock
             failureBlock:(modelFailureBlock)failureBlock;

/**
 *  Indicator of loading state
 *
 *  @return BOOL value, loading or not
 */
- (BOOL)isLoading;

/**
 *  Indicator whether model can load more items or not
 *
 *  @return BOOL value, can load more or not
 */
- (BOOL)canLoadMore;

@end
