//
//  ThirdDetailViewController.m
//  Calculator
//
//  Created by Will Jackson on 1/6/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import "ThirdDetailViewController.h"
#import "SecondDetailViewController.h"

#define cellHeight 22

@interface ThirdDetailViewController ()

@end

@implementation ThirdDetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.historyListView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:.92f alpha:1];
    self.historyListView.separatorColor = [UIColor colorWithRed:1 green:1 blue:.92f alpha:1];
    
    self.referencedHistory = [[History alloc] init];
    
    self.referencedHistory = [self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex];


    
    self.mail = [[UIBarButtonItem alloc] initWithTitle:@"Email" style:UIBarButtonItemStyleBordered target:self action:@selector(mail:)];
    
    self.navigationItem.rightBarButtonItem = self.mail;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = [[self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex] name];
    [self.historyListView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.historyListView reloadData];
}

//- (void)viewDidDisappear:(BOOL)animated{
//    [self.navigationController popToRootViewControllerAnimated:YES ];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.referencedHistory.tape count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"MyReuseIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myIdentifier];
    }
    cell.detailTextLabel.text = [self.referencedHistory.tape objectAtIndex:[indexPath row]];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Courier New" size:20];
    
    return cell;

    
    // Configure the cell...
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.detailViewController = [[SecondDetailViewController alloc] init];
    self.detailViewController.referencedHistory = self.referencedHistory;
    self.detailViewController.referencedTapeLine = [indexPath row];
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)goToBottom: (BOOL) animated{
    CGPoint bottomOffset = CGPointMake(0, self.historyListView.contentSize.height - self.historyListView.bounds.size.height);
    [self.historyListView setContentOffset:bottomOffset animated:animated];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([[[self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex] tape] count] * cellHeight < self.historyListView.frame.size.height){
        scrollView.scrollEnabled = NO;
    }
    else{
        scrollView.scrollEnabled = YES;
    }
}

- (void) mail: (id) sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        self.mailViewController = [[MFMailComposeViewController alloc] initWithNibName:@"mailViewController" bundle:NULL];
        self.mailViewController.mailComposeDelegate = self;
        
        NSString *subject = [NSString stringWithFormat:@"\"%@\" sent using TapeCalc", [[self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex] name]];
        
        NSString *body = [[NSString alloc] init];
        
        for(int i = 0; i < [[[self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex] tape] count]; i++){
            body = [NSString stringWithFormat:@"%@\n%@", body, [[[self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex] tape] objectAtIndex:i]];
        }
        
        [self.mailViewController setSubject:subject];
        [self.mailViewController setMessageBody:body isHTML:NO];
          
        [self presentViewController:self.mailViewController animated:YES completion:NULL];
          
        }
    else {
        NSLog(@"Device is unable to send email in its current state.");
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self goToBottom:NO];
    [self.mailViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
