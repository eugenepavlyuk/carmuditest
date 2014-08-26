//
//  ItemTableViewCell.m
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 8/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import "ItemTableViewCell.h"
#import "Item.h"
#import <UIImageView+AFNetworking.h>

static NSString *kItemTableViewCellIdentifier = @"ItemTableViewCellIdentifier";

@implementation ItemTableViewCell

+ (NSString*)cellIdentifier
{
    return kItemTableViewCellIdentifier;
}

- (void)configureCellWithItem:(Item*)item
{
    _item = item;
    
    self.titleLabel.text = item.name;
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@ - %@", item.brand, item.price];
    
    NSURL *url = [NSURL URLWithString:item.image];
    
    __weak ItemTableViewCell *weakSelf = self;
    
    [self.previewImageView setImageWithURLRequest:[NSURLRequest requestWithURL:url]
                                 placeholderImage:nil
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                              
                                              if ([request.URL.absoluteString isEqualToString:url.absoluteString])
                                              {
                                                  weakSelf.previewImageView.image = image;
                                              }
                                              
                                          } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                              
                                              if ([request.URL.absoluteString isEqualToString:url.absoluteString])
                                              {
                                                  weakSelf.previewImageView.image = nil;
                                              }
                                              
                                          }];
}

@end
