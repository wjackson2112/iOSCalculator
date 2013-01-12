//
//  ThirdDisclosureViewController.m
//  Calculator
//
//  Created by Will Jackson on 1/8/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import "ThirdDisclosureViewController.h"

@interface ThirdDisclosureViewController ()

@end

@implementation ThirdDisclosureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Edit Tape", @"Edit Tape");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex] setName:self.name.text];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController popToRootViewControllerAnimated:YES ];
}

- (void) done: (id) sender{
    [[self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex] setName:self.name.text];
    [self.name resignFirstResponder];
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
    return 2;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if([indexPath row] == 0){
        self.name = [[UITextField alloc] initWithFrame:CGRectMake(110, 9, 185, 29)];
        self.name.borderStyle = UITextBorderStyleRoundedRect;
        self.name.adjustsFontSizeToFitWidth = YES;
        self.name.textColor = [UIColor blackColor];
        self.name.placeholder = [[self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex] name];
        self.name.text = [[self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex] name];
        self.name.returnKeyType = UIReturnKeyDone;
        self.name.delegate = self;
        [cell addSubview:self.name];
        cell.textLabel.text = @"Name";
    }

    if([indexPath row] == 1){
        cell.textLabel.text = @"Recall To Calculator";
    }
    
    return cell;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row] == 1){
        self.delegate.history = [[self.delegate.savedHistories objectAtIndex:self.referencedHistoryIndex] copy];
        [self.tabBarController setSelectedIndex:0];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
