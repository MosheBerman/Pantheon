//
//  PNProjectsChooserViewController.h
//  Pantheon
//
//  Created by Moshe Berman on 11/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PNFileChooserCompletion)(NSURL *url);

@interface PNProjectsChooserViewController : UITableViewController

/**
 *  Displays the file chooser and then runs the appropriate block upon dismissal.
 *
 *  @param completionHandler A block to be executed if a file is chosen.
 *  @param cancellationHandler A block to execute if the selection if cancelled.
 */

- (void)showWithCompletionHandler:(PNFileChooserCompletion)completionHandler andCancellationHandler:(PNFileChooserCompletion)cancellationHandler;

@end
