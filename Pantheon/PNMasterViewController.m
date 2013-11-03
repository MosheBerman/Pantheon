//
//  PNMasterViewController.m
//  Pantheon
//
//  Created by Moshe Berman on 10/14/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PNMasterViewController.h"

#import "PNDetailViewController.h"

#import "PBXProject.h"

@interface PNMasterViewController ()

@property (nonatomic, strong) PBXProject *project;

@end

@implementation PNMasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(displayOpenPrompt:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (PNDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger count = [[[self project] PBXFileReferences] count];
    
    if (count == 0) {
        count = 3;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSArray *files = [[self project] PBXFileReferences];
    
    if (files.count == 0) {
        if (indexPath.row == 1) {
            cell.textLabel.text = NSLocalizedString(@"No Files", @"A string for when there are no files.");
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        else
        {
            cell.textLabel.text = @"";
        }
    }
    else {
        PBXFileReference *object = files[indexPath.row];
        cell.textLabel.text = [object name];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  TODO: Load the file up - we need the Xcode project to be completely built for this to work, though.
     */
    
}

#pragma mark - Display Open Prompt

- (void)displayOpenPrompt
{
    
}

@end
