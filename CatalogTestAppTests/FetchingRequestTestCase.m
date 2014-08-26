//
//  FetchingRequestTestCase.m
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 8/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import "XCTestCase+AsyncTesting.h"
#import "ConnectionManager.h"

@interface FetchingRequestTestCase : XCTestCase

@end

@implementation FetchingRequestTestCase
{
    NSMutableDictionary *parameters;
}

- (void)setUp
{
    [super setUp];
    
    parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:@"popularity" forKey:kSortKey];
    [parameters setObject:[NSString stringWithFormat:@"%i", 1] forKey:kPageKey];
}

- (void)tearDown
{
    parameters = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    [[ConnectionManager sharedInstance] loadItemsWithInfo:parameters
                                          completionBlock:^(id object) {
                                              
                                              [self XCA_notify:XCTAsyncTestCaseStatusSucceeded];
                                              
                                              NSLog(@"request finished with success");
                                              
                                          } failureBlock:^{
                                              
                                              XCTFail(@"Request failed with this input parameters \"%s\"", __PRETTY_FUNCTION__);

                                          }];
    
    [self XCA_waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:60.f];
}

@end
