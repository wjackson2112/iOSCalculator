//
//  ThirdViewController.m
//  Calculator
//
//  Created by Will Jackson on 1/4/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import "ThirdViewController.h"
#import "ThirdDetailViewController.h"
#import "ThirdDisclosureViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Saved Tapes", @"Saved Tapes");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    //self.navController = [[UINavigationController alloc] initWithRootViewController:self];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [self.listOfSaves reloadData];
    self.listOfSaves.editing = NO;
}

- (void)viewDidAppear:(BOOL) animated{
    [self.listOfSaves reloadData];

    self.edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = self.edit;
}

- (void) edit:(id) sender{
    if(self.listOfSaves.editing == NO)
        [self.listOfSaves setEditing:YES];
    else
        [self.listOfSaves setEditing:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.delegate.savedHistories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.delegate.savedHistories objectAtIndex:[indexPath row]] name];
    cell.detailTextLabel.text = [[self.delegate.savedHistories objectAtIndex:[indexPath row]] dateAndTimeToString];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    // Configure the cell...
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *) indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.delegate.savedHistories removeObjectAtIndex:[indexPath row]];
        [self.listOfSaves deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    ThirdDisclosureViewController *thirdDisclosureViewController = [[ThirdDisclosureViewController alloc] initWithNibName:@"ThirdDisclosureViewController" bundle:nil];
    thirdDisclosureViewController.referencedHistoryIndex = [indexPath row];
    thirdDisclosureViewController.delegate = self.delegate;
    
    [self.navigationController pushViewController:thirdDisclosureViewController animated:YES];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    self.detailViewController = [[ThirdDetailViewController alloc] initWithNibName:@"ThirdDetailViewController" bundle:nil];
    [self.detailViewController setReferencedHistoryIndex:[indexPath row]];
    self.detailViewController.delegate = self.delegate;
    
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:self.detailViewController animated:YES];
    
}

@end
