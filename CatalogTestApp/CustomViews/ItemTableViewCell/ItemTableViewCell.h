//
//  ItemTableViewCell.h
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 8/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface ItemTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *previewImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinnerView;
@property (nonatomic, strong) Item *item;

+ (NSString*)cellIdentifier;

- (void)configureCellWithItem:(Item*)item;

@end
