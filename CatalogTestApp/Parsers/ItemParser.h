//
//  ItemParser.h
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 08/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemParser : NSObject

@property (nonatomic, readonly, assign) BOOL success;

/**
 *  Method for parsing data
 *
 *  @param response NSData  - data from the server
 *
 *  @return YES if parsing is successfull.
 */
- (BOOL)parseResponse:(NSData*)response;

@end
