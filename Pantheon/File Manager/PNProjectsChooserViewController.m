//
//  PNProjectsChooserViewController.m
//  Pantheon
//
//  Created by Moshe Berman on 11/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PNProjectsChooserViewController.h"

const NSString *CellIdentifier = @"Cell Identifier";

@interface PNProjectsChooserViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 *  A handler to run when the user chooses a project.
 */
@property (nonatomic, strong) PNFileChooserCompletion completionHandler;

/**
 *  A handler to run when the user cancels the selection process.
 */
@property (nonatomic, strong) PNFileChooserCompletion cancellationHandler;

/**
 *  An array of files that exist in the documents directory.
 */

@property (nonatomic, strong) NSMutableArray *filesInDocumentsDirectory;

/**
 *  A tableViewController to display the data
 */

@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation PNProjectsChooserViewController

- (id)init
{

    self = [super init];
    
    if (self) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];;
        _navigationController = navigationController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    /* Set the data source and delegate. */
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    
    /* Register a cell class to use. */
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:(NSString *)CellIdentifier];
    
    /* Set up close button. */
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    [[self navigationItem] setLeftBarButtonItems:@[closeButton] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self loadFilesFromDocumentsDirectory];
    [[self tableView] reloadData];
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
    NSInteger count = [[self filesInDocumentsDirectory] count];
    
    if (!count) {
        count = 3;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CellIdentifier forIndexPath:indexPath];
    
    NSInteger count = [[self filesInDocumentsDirectory] count];
    
    if (!count) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 1) {
            cell.textLabel.text = NSLocalizedString(@"No Projects", @"A string for when there are no files.");
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        }
        else
        {
            cell.textLabel.text = @"";
        }
    }
    else
    {
        /* Prevent out of bounds errors. */
        
        if (indexPath.row < count)
        {
            /* Show the project's name. */
            NSString *path = [(NSString *)([self filesInDocumentsDirectory][[indexPath row]]) lastPathComponent];
            cell.textLabel.text = path;
        
            /* Properly color the text. */
            cell.textLabel.textColor = [[self view] tintColor];
            
            /* Properly align and color the text. */
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /* Get the projects in the documents directory. */
    NSArray *files = [self filesInDocumentsDirectory];

    if ([indexPath row] < [files count]) {
        
        /* We need a completion handler or there's nothing to do but dismiss. */
        if ([self completionHandler]) {
            
            /* Get the filename.*/
            NSString *fileName = files[[indexPath row]];
            
            /* Create a URL with the fileName */
            NSURL *url = [[NSURL URLWithString:[self documentsDirectory]] URLByAppendingPathComponent:fileName];
            
            /* Pass the url to the completio  handler. */
            self.completionHandler(url);
        }
        
        [self dismiss];
    }
}

#pragma mark - Presentation & Dismissal

- (void)showWithCompletionHandler:(PNFileChooserCompletion)completionHandler andCancellationHandler:(PNFileChooserCompletion)cancellationHandler
{
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];

    /**
     *  If we've got access to the app's main view controller,
     *  then we can use it to show the list of files.
     */
    
    if (rootViewController) {
        
        /* Hang on to the completion handlers. */
        _completionHandler = completionHandler;
        _cancellationHandler = cancellationHandler;
        
        /* Reload the files. */
        [self loadFilesFromDocumentsDirectory];
        [[self tableView] reloadData];
        
        /* Present self inside of a navigation controller. */
        [[self navigationController] setModalPresentationStyle:UIModalPresentationFormSheet];
        [rootViewController presentViewController:[self navigationController] animated:YES completion:nil];
    }
    
    /* The root view controller doesn't exist, uh oh! */
    else {
        NSLog(@"The root view controller does not exist. I was expecting it to be there to present. Silently failing.");
    }
}

/**
 *  Dismisses the view.
 */

- (void)dismiss
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - File Related

/**
 *  Returns the path to the app's documents directory.
 *
 *  @return A string representing the path to the app's document's directory.
 */

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return documentsPath;
}

/**
 *  Reads out the file names at a given path.
 *
 *  @property path The path to inspect.
 *
 *  @return An array of strings.
 */

- (NSMutableArray *)filesAtPath:(NSString *)path
{
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:path];
    
    NSMutableArray *filenames = [[NSMutableArray alloc] init];
    
    id file = nil;
    
    while (file = [fileEnumerator nextObject]) {
        if ([[file pathExtension] isEqualToString:@"xcodeproj"]) {
            [filenames addObject:file];
        }
    }
    
    return filenames;
}

/**
 *  Loads the Xcode projects into an array.
 */

- (void)loadFilesFromDocumentsDirectory
{
    _filesInDocumentsDirectory = [self filesAtPath:[self documentsDirectory]];
}


@end
