//
//  PNMasterViewController.m
//  Pantheon
//
//  Created by Moshe Berman on 10/14/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PNMasterViewController.h"

#import "PNDetailViewController.h"

#import "PBXProjectDotPBXProj.h"

#import "PNProjectsChooserViewController.h"

@interface PNMasterViewController ()

@property (nonatomic, strong) PBXProjectDotPBXProj *project;

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
    self.navigationItem.leftBarButtonItem = addButton;
    self.detailViewController = (PNDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
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
    
    NSArray *files = [[self project] PBXFileReferences];
    
    if ([indexPath row] < [files count]) {
        PBXFileReference *reference = [[self project] PBXFileReferences][[indexPath row]];
        NSString *filePath = [[self project] resolvePathToFileReference:reference];
    }
    
    /**
     *  As I see it, there are several kinds of
     *  actionable object categories:
     *
     *  1. NIB/Storyboard files - require visual rendering/editor. Can also be opened as XML source
     *  2. Images, which are previewed in place.
     *  3. Nonpreviewable Items, like frameworks and binaries. Preview the file type icon.
     *  4. Groups - Expans/contract
     *  5. Audio Files - Can be played.
     *  6. Property Lists - Tree editor.
     *  7. Source Code - Everything else, dited with a (syntax aware) text editor.
     *
     */
    
    
}

#pragma mark - Display Open Prompt

- (void)displayOpenPrompt:(id)sender
{
    PNProjectsChooserViewController *projectChooser = [[PNProjectsChooserViewController alloc] init];
    [projectChooser showWithCompletionHandler:^(NSURL *url) {
        
        if(url)
        {
            /* Attempt to load the project. */
            NSError *error = nil;
            PBXProjectDotPBXProj *project = [PBXProjectDotPBXProj projectFromXcodeProjectAtURL:url error:&error];
            
            if (project) {
                
                [self setProject:project];
            
                [[self tableView] reloadData];
                NSString *title = [[[self.project.projectURL lastPathComponent] componentsSeparatedByString:@"."] firstObject];
                [self setTitle:title];
            }
            
        }
    } andCancellationHandler:^(NSURL *url) {

    }];
}

@end
