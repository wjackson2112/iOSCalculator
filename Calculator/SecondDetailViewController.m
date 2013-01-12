//
//  SecondDetailViewController.m
//  TapeCalc
//
//  Created by Will Jackson on 1/10/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import "SecondDetailViewController.h"

#define SECTION_COUNT   3

#define EDIT_SECTION    0
#define TRIM_SECTION    1
#define ADD_SECTION     2

#define EDIT_SECTION_NAME   @"Edit"
#define TRIM_SECTION_NAME   @"Trim"
#define ADD_SECTION_NAME    @"Add"

#define EDIT_SECTION_COUNT  2
#define TRIM_SECTION_COUNT  3
#define ADD_SECTION_COUNT   2

#define TRIM_ABOVE      0
#define TRIM_LINE       1
#define TRIM_BELOW      2

#define ADD_ABOVE       0
#define ADD_BELOW       1

#define EDIT            0
#define RESTORE         1

@interface SecondDetailViewController ()

@end

@implementation SecondDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"It Appeared");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return SECTION_COUNT;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section){
        case EDIT_SECTION:
            return EDIT_SECTION_NAME;
        case TRIM_SECTION:
            return TRIM_SECTION_NAME;
        case ADD_SECTION:
            return ADD_SECTION_NAME;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section){
        case EDIT_SECTION:
            return EDIT_SECTION_COUNT;
        case TRIM_SECTION:
            return TRIM_SECTION_COUNT;
        case ADD_SECTION:
            return ADD_SECTION_COUNT;
        default:
            return 0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myIdentifier = @"MyReuseIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myIdentifier];
    }
    
    switch ([indexPath section]){
        case TRIM_SECTION:
            switch ([indexPath row]){
                case TRIM_ABOVE:
                    cell.textLabel.text = @"Trim Lines Above";
                    break;
                case TRIM_LINE:
                    cell.textLabel.text = @"Trim This Line";
                    break;
                case TRIM_BELOW:
                    cell.textLabel.text = @"Trim Lines Below";
                    break;
            }
            break;
        case ADD_SECTION:
            switch ([indexPath row]){
                case ADD_ABOVE:
                    cell.textLabel.text = @"Add Line Above";
                    break;
                case ADD_BELOW:
                    cell.textLabel.text = @"Add Line Below";
                    break;
            }
            break;
        case EDIT_SECTION:
            switch ([indexPath row]){
                case EDIT:
                    //cell.textLabel.text = @"Edit This Line";
                    self.editThisLine = [[UITextField alloc] initWithFrame:CGRectMake(110, 9, 185, 29)];
                    self.editThisLine.borderStyle = UITextBorderStyleRoundedRect;
                    self.editThisLine.adjustsFontSizeToFitWidth = YES;
                    self.editThisLine.textColor = [UIColor blackColor];
                    self.editThisLine.placeholder = [self.referencedHistory.tape objectAtIndex:self.referencedTapeLine];
                    self.editThisLine.text = [self.referencedHistory.tape objectAtIndex:self.referencedTapeLine];
                    self.editThisLine.returnKeyType = UIReturnKeyDone;
                    self.editThisLine.delegate = self;
                    [cell addSubview:self.editThisLine];
                    cell.textLabel.text = @"Edit";
                    break;
                case RESTORE:
                    cell.textLabel.text = @"Restore Original Tape";
            }
            break;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch ([indexPath section]){
        case TRIM_SECTION:
            switch ([indexPath row]){
                case TRIM_ABOVE:
                    for(int i = 0; i < self.referencedTapeLine; i++){
                        NSLog([NSString stringWithFormat:@"%@", [self.referencedHistory.tape objectAtIndex:0]]);
                        [self.referencedHistory.tape removeObjectAtIndex:0];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                case TRIM_LINE:
                    for(int i = 0; i < [self.referencedHistory.tape count] - self.referencedTapeLine - 1; i++){
                        [self.referencedHistory.tape removeObjectAtIndex:self.referencedTapeLine];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                case TRIM_BELOW:
                    NSLog([NSString stringWithFormat:@"%d", self.referencedTapeLine]);
                    
                    while([self.referencedHistory.tape count] > self.referencedTapeLine + 1){
                        NSLog([NSString stringWithFormat:@"%d", [self.referencedHistory.tape count]]);
                        NSLog([NSString stringWithFormat:@"%@", [self.referencedHistory.tape lastObject]]);
                        [self.referencedHistory.tape removeLastObject];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
            }
            break;
        case ADD_SECTION:
            switch ([indexPath row]){
                case ADD_ABOVE:
                    [self.referencedHistory.tape insertObject:@"" atIndex:self.referencedTapeLine - 1];
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                case ADD_BELOW:
                    [self.referencedHistory.tape insertObject:@"" atIndex:self.referencedTapeLine + 1];
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
            }
        case EDIT_SECTION:
            switch ([indexPath row]){
                case EDIT:
                    [tableView deselectRowAtIndexPath:indexPath animated:NO];
                    break;
                case RESTORE:
                    [self.referencedHistory restoreTape];
                    [self.navigationController popViewControllerAnimated:YES];
            }
            break;
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.editThisLine){
        self.referencedHistory.tape[self.referencedTapeLine] = self.editThisLine.text;
    }
    [textField resignFirstResponder];
    return YES;
}

@end
