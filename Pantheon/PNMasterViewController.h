//
//  PNMasterViewController.h
//  Pantheon
//
//  Created by Moshe Berman on 10/14/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PNDetailViewController;
@protocol PNFileBrowserDelegateProtocol;

@interface PNMasterViewController : UITableViewController

@property (strong, nonatomic) PNDetailViewController *detailViewController;

@property (nonatomic, strong) id<PNFileBrowserDelegateProtocol> delegate;

@end
