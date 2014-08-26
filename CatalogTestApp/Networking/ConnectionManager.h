//
//  ConnectionManager.h
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 08/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completionBlock) (id object);
typedef void (^failureBlock) ();

@interface ConnectionManager : NSObject

+ (ConnectionManager*)sharedInstance;

/**
 *  Method for fetching data from the server
 *
 *  @param info       Dictionary with parameters
 *  @param completion block for completion handling
 *  @param failure    block for failure handling
 */
- (void)loadItemsWithInfo:(NSDictionary*)info
          completionBlock:(completionBlock)completion
             failureBlock:(failureBlock)failure;

@end
