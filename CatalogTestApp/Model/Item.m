//
//  Item.m
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 08/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import "Item.h"


@implementation Item

@dynamic itemId;
@dynamic name;
@dynamic image;
@dynamic brand;
@dynamic price;
@dynamic date;

- (void)updateWithInfo:(NSDictionary*)info
{
    self.itemId = info[kItemIdKey];
    self.name = info[kDataKey][kNameKey];
    
    NSDictionary *anyImage = [info[kImagesKey] lastObject];
    
    self.image = anyImage[kPathKey];
    self.brand = info[kDataKey][kBrandKey];
    self.price = info[kDataKey][kPriceKey];
    
    self.date = [NSDate date];
}

@end
