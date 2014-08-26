 //
//  ConnectionManager.m
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 08/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import "ConnectionManager.h"
#import "AFNetworking.h"

static ConnectionManager *connectionManager = nil;

@interface ConnectionManager()
{
    AFHTTPClient *client;
}

@end


@implementation ConnectionManager

+ (ConnectionManager*)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        connectionManager = [[ConnectionManager alloc] init];
    });
    
    return connectionManager;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
    }
    
    return self;
}

/**
 *  Method for fetching data from the server
 *
 *  @param info       Dictionary with parameters
 *  @param completion block for completion handling
 *  @param failure    block for failure handling
 */
- (void)loadItemsWithInfo:(NSDictionary*)info
          completionBlock:(completionBlock)completion
             failureBlock:(failureBlock)failure
{
    NSMutableDictionary *parameters = [info mutableCopy];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [parameters setObject:@"25" forKey:kMaxitemsKey];
    }
    else
    {
        [parameters setObject:@"15" forKey:kMaxitemsKey];
    }
    
    [parameters setObject:kDescKey forKey:kDirKey];
    
    NSMutableURLRequest *request = [client requestWithMethod:@"GET" path:kCatalogUrl parameters:parameters];
    
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion)
        {
            completion(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
        {
            failure();
        }
    }];
    
    [client enqueueHTTPRequestOperation:operation];
}

@end
