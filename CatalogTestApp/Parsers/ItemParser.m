//
//  ItemParser.m
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 08/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import "ItemParser.h"
#import "Item.h"
#import <NSManagedObject+MagicalFinders.h>
#import <NSManagedObject+MagicalRecord.h>

@interface ItemParser()

@end 


@implementation ItemParser
{
    BOOL _success;
}

- (BOOL)parseResponse:(NSData*)response
{
    NSError *error = nil;
    
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    
    if (!error)
    {
        _success = [responseDictionary[@"success"] boolValue];
        
        NSDictionary *dataDictionary = responseDictionary[@"metadata"];
        
        NSArray *children = dataDictionary[@"results"];
        
        for (NSDictionary *child in children)
        {
            NSString *itemId = child[kItemIdKey];
            
            Item *item = [Item MR_findFirstByAttribute:@"itemId" withValue:itemId];
            
            if (!item)
            {
                item = [Item MR_createEntity];
            }
            
            [item updateWithInfo:child];
        }
    }
    else
    {
        _success = NO;
    }
    
    return _success;
}

@end
