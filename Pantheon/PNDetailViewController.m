//
//  PNDetailViewController.m
//  Pantheon
//
//  Created by Moshe Berman on 10/14/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PNDetailViewController.h"

#import "PBXProjectDotPBXProj.h"

@interface PNDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;

@property (nonatomic, strong) PBXFileReference *fileReference;
@property (nonatomic, strong) PBXProjectDotPBXProj *project;

@end

@implementation PNDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Project", @"A label for the button that shows the project viewer.");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

#pragma mark - PNFileBrowserDelegateProtocol

- (void)fileBrowserDidSelectFile:(PBXFileReference *)file inProject:(PBXProjectDotPBXProj *)project
{
    
    [self setFileReference:file];
    [self setProject:project];
    
    NSString *filePath = [[self project] absolutePathToFileReference:[self fileReference]];
    
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfFile:filePath  options:0 error:&error];
    
    NSString *contents = nil;
    
    if (!error) {
        contents = [NSString stringWithUTF8String:[data bytes]];
    }
    else
    {
        NSLog(@"Error: %@, %@, %@", [error localizedDescription], [[error userInfo] description], [[error userInfo][@"NSFilePath"] description]);
    }
    
    [[self textView] setText:contents];
}



@end
