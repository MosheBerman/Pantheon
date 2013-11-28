//
//  PNDetailViewController.h
//  Pantheon
//
//  Created by Moshe Berman on 10/14/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PNFileBrowserDelegateProtocol.h"

@interface PNDetailViewController : UIViewController <UISplitViewControllerDelegate, PNFileBrowserDelegateProtocol>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
