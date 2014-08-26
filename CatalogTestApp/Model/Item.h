//
//  Item.h
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 08/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define kItemEntity     @"Item"

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * itemId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSDate * date;

- (void)updateWithInfo:(NSDictionary*)info;

@end
