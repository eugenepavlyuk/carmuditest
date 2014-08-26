//
//  ListViewController.h
//  CatalogTestApp
//
//  Created by Eugene Pavlyuk on 08/26/14.
//  Copyright (c) 2014 Eugene Pavlyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UISegmentedControl *segmentControl;
}

/**
 *  this method is called every time when user selects type of sorting
 *
 *  @param sender sender of the event (UISegmentControl for sorting)
 */
- (IBAction)segmentControlValueChanged:(UISegmentedControl*)sender;

@end
