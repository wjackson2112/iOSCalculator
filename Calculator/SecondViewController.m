//
//  SecondViewController.m
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import "SecondViewController.h"
#import "HistoricOperation.h"
#import <QuartzCore/QuartzCore.h>

#import "SecondDetailViewController.h"

#define cellHeight 22

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Current Tape", @"Current Tape");
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;

    self.historyListView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:.92f alpha:1];
    self.historyListView.separatorColor = [UIColor colorWithRed:1 green:1 blue:.92f alpha:1];
    self.historyListView.allowsSelection = YES;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.historyListView reloadData];
    [self goToBottom:NO];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trash:)];
    self.saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    
    self.navigationItem.rightBarButtonItem = self.clearButton;
    self.navigationItem.leftBarButtonItem = self.saveButton;

    [self.historyListView reloadData];
    [self goToBottom:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.delegate.history.tape count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myIdentifier = @"MyReuseIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myIdentifier];
    }
    cell.detailTextLabel.text = [self.delegate.history.tape objectAtIndex:[indexPath row]];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Courier New" size:20];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondDetailViewController *secondDetailViewController = [[SecondDetailViewController alloc] init];
    secondDetailViewController.referencedHistory = self.delegate.history;
    secondDetailViewController.referencedTapeLine = [indexPath row];
    
    [self.navigationController pushViewController:secondDetailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)trash:(id)sender{
    [self.delegate.history clear];
    [self.historyListView reloadData];
    [self goToBottom:NO];
}

- (void)save:(id)sender{
    if([self.delegate.history.tape count] > 0) {
        self.delegate.history.date = [NSDate date];
        self.delegate.history.name = @"Saved Tape";
    
        [self.delegate.savedHistories addObject:[self.delegate.history copy]];
        [self.delegate.history clear];
        [self.historyListView reloadData];
        [self goToBottom:NO];
    }
}

- (void)goToBottom: (BOOL) animated{
    CGPoint bottomOffset = CGPointMake(0, self.historyListView.contentSize.height - self.historyListView.bounds.size.height);
    [self.historyListView setContentOffset:bottomOffset animated:animated];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self.delegate.history.tape count] * cellHeight < self.historyListView.frame.size.height){
        scrollView.scrollEnabled = NO;
    }
    else{
        scrollView.scrollEnabled = YES;
    }
}

@end
