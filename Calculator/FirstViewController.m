//
//  FirstViewController.m
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "HistoricOperation.h"
#import <QuartzCore/QuartzCore.h>

#define tableLines 8
#define cellHeight 22

@interface FirstViewController ()

@end

@implementation FirstViewController

enum {
    ADD = 10,
    SUBTRACT,
    MULTIPLY,
    DIVIDE,
    SOLUTION,
    CLEAR,
    CHANGE_SIGN,
    DECIMAL_POINT,
    ACLEAR,
    PERCENT,
    MMINUS,
    MPLUS,
    MCLEAR,
    MRECALL
};

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Calculator", @"Calculator");
    }
    return self;
}
							
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlasticCalculatorIphone5.png"]];
    backgroundImage.frame = self.view.frame;
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    self.display.backgroundColor = [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1];
    self.bottomOfTape.backgroundColor = [UIColor colorWithRed:1 green:1 blue:.92f alpha:1];
    self.bottomOfTape.separatorColor = [UIColor colorWithRed:1 green:1 blue:.92f alpha:1];
    self.bottomOfTape.scrollEnabled = NO;
    
    [self initButton:self.zeroButton        tag:0               color:[UIColor colorWithRed:0 green:0 blue:.3f alpha:1]     title:@"0"];
    [self initButton:self.oneButton         tag:1               color:[UIColor colorWithRed:0 green:0 blue:.3f alpha:1]     title:@"1"];
    [self initButton:self.twoButton         tag:2               color:[UIColor colorWithRed:0 green:0 blue:.3f alpha:1]     title:@"2"];
    [self initButton:self.threeButton       tag:3               color:[UIColor colorWithRed:0 green:0 blue:.3f alpha:1]     title:@"3"];
    [self initButton:self.fourButton        tag:4               color:[UIColor colorWithRed:0 green:0 blue:.3f alpha:1]     title:@"4"];
    [self initButton:self.fiveButton        tag:5               color:[UIColor colorWithRed:0 green:0 blue:.3f alpha:1]     title:@"5"];
    [self initButton:self.sixButton         tag:6               color:[UIColor colorWithRed:0 green:0 blue:.3f alpha:1]     title:@"6"];
    [self initButton:self.sevenButton       tag:7               color:[UIColor colorWithRed:0 green:0 blue:.3f alpha:1]     title:@"7"];
    [self initButton:self.eightButton       tag:8               color:[UIColor colorWithRed:0 green:0 blue:.3f alpha:1]     title:@"8"];
    [self initButton:self.nineButton        tag:9               color:[UIColor colorWithRed:0 green:0 blue:.3f alpha:1]     title:@"9"];
    [self initButton:self.addButton         tag:ADD             color:[UIColor colorWithRed:0 green:.2f blue:0 alpha:1]     title:@"+"];
    [self initButton:self.subtractButton    tag:SUBTRACT        color:[UIColor colorWithRed:0 green:.2f blue:0 alpha:1]     title:@"-"];
    [self initButton:self.multiplyButton    tag:MULTIPLY        color:[UIColor colorWithRed:0 green:.2f blue:0 alpha:1]     title:@"X"];
    [self initButton:self.divideButton      tag:DIVIDE          color:[UIColor colorWithRed:0 green:.2f blue:0 alpha:1]     title:@"÷"];
    [self initButton:self.equalButton       tag:SOLUTION        color:[UIColor colorWithRed:0 green:.2f blue:0 alpha:1]     title:@"="];
    [self initButton:self.signButton        tag:CHANGE_SIGN     color:[UIColor colorWithRed:0 green:.2f blue:0 alpha:1]     title:@"+/-"];
    [self initButton:self.cButton           tag:CLEAR           color:[UIColor colorWithRed:.5f green:0 blue:0 alpha:1]     title:@"C"];
    [self initButton:self.decimalButton     tag:DECIMAL_POINT   color:[UIColor colorWithRed:0 green:.2f blue:0 alpha:1]     title:@"."];
    [self initButton:self.acButton          tag:ACLEAR          color:[UIColor colorWithRed:.5f green:0 blue:0 alpha:1]     title:@"AC"];
    [self initButton:self.percentButton     tag:PERCENT         color:[UIColor colorWithRed:0 green:.2f blue:0 alpha:1]     title:@"%"];
    [self initButton:self.mMinusButton      tag:MMINUS          color:[UIColor blackColor]                                  title:@"M-"];
    [self initButton:self.mPlusButton       tag:MPLUS           color:[UIColor blackColor]                                  title:@"M+"];
    [self initButton:self.mClearButton      tag:MCLEAR          color:[UIColor blackColor]                                  title:@"MC"];
    [self initButton:self.mRecallButton     tag:MRECALL         color:[UIColor blackColor]                                  title:@"MR"];
    
    self.doubleFingerPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleFingerPan:)];
    self.doubleFingerPan.minimumNumberOfTouches = 2;
    self.doubleFingerPan.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:self.doubleFingerPan];
    self.view.multipleTouchEnabled = YES;
    
    self.display.font = [UIFont fontWithName:@"DBLCDTempBlack" size:50.0];
    self.display.textColor = [UIColor blackColor];
    //self.historyDisplay.font = [UIFont fontWithName:@"DBLCDTempBlack" size:20.0];
    
    self.memory = 0;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.bottomOfTape reloadData];
    [self goToBottom];
    self.ignoreTransition = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initButton:(UIButton*)button tag:(int) tag color:(UIColor*) color title:(NSString*) title{
    [button addTarget:self action:@selector(sendInput:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:tag];
    [button.layer setCornerRadius:7.0f];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = color;
    button.layer.masksToBounds = true;
}

- (void)appendToDisplay:(NSString*)nextChar {
    if(([self.display.text isEqualToString:@"0"] || [self.display.text isEqualToString:@""]) && [nextChar isEqualToString:@"."]){
        self.display.text = @"0.";
        return;
    }
    else if ([self.display.text isEqualToString:@"0"] && [nextChar isEqualToString:@"0"]){
        self.display.text = @"0";
        return;
    }
    else if ([self.display.text isEqualToString:@"0"])
        self.display.text = @"";
    self.display.text = [NSString stringWithFormat:@"%@%@", self.display.text, nextChar];
}

- (void)clearDisplay {
    self.display.text = @"";
}

- (void)zeroOutDisplay{
    self.display.text = @"0";
}

- (void)clear{
    [self zeroOutDisplay];
}

- (void)sendInput:(id)sender {
    
    switch ([sender tag]) {
        case 0: case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8: case 9:
            if([self.delegate.history lastInputWasOperation] || [self.delegate.history lastInputWasEvaluation])
                [self clearDisplay];
            
            [self appendToDisplay:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:[sender tag]]]];
            [self.delegate.history.currentFormula setLastInputOperand];
            break;
        case ADD: case SUBTRACT: case MULTIPLY: case DIVIDE: case PERCENT:
            
            if([sender tag] == PERCENT){
                self.display.text = [NSString stringWithFormat:@"%g", [[self.delegate.history.currentFormula evaluate] floatValue] * [self.display.text floatValue]/100];
                break;
            }
            
            [self.delegate.history addOperand:[NSNumber numberWithFloat:[self.display.text floatValue]]];
            
            if([sender tag] == ADD){
                [self.delegate.history addOperation:@"+"];
            }
            if([sender tag] == SUBTRACT){
                [self.delegate.history addOperation:@"-"];
            }
            if([sender tag] == MULTIPLY){
                [self.delegate.history addOperation:@"*"];
            }
            if([sender tag] == DIVIDE){
                [self.delegate.history addOperation:@"/"];
            }

            
            [self.bottomOfTape reloadData];
            [self goToBottom];
            break;
        case SOLUTION:
            
            [self.delegate.history addOperand:[NSNumber numberWithFloat:[self.display.text floatValue]]];
            self.display.text = [self.delegate.history evaluate];
            
            
            [self.bottomOfTape reloadData];
            [self goToBottom];
            
            break;
        case CHANGE_SIGN:
            if([self.delegate.history lastInputWasOperation]) [self clearDisplay];
            if([self.delegate.history lastInputWasEvaluation]) [self clear];
            self.display.text = [[[NSNumber alloc] initWithDouble:[self.display.text floatValue] * -1] stringValue];
            if([self.display.text floatValue] == 0){
                self.display.text = @"0";
            }
            break;
        case ACLEAR:
            [self.delegate.history clearCurrentOperation];
            [self.bottomOfTape reloadData];
            [self goToBottom];
        case CLEAR:
            if([self.delegate.history lastInputWasEvaluation] || [self.display.text isEqualToString:@"0"]){
                [self.bottomOfTape reloadData];
                [self goToBottom];
            }
            [self zeroOutDisplay];
            break;

        case DECIMAL_POINT:
            if([self.delegate.history lastInputWasOperation]) [self clearDisplay];
            if([self.delegate.history lastInputWasEvaluation]) [self clear];
            if([self.display.text rangeOfString:@"."].location == NSNotFound){
                [self appendToDisplay:@"."];
                
            }
            [self.delegate.history.currentFormula setLastInputOperand];
            break;
        case MPLUS:
            self.memory += [self.display.text floatValue];
            break;
        case MMINUS:
            self.memory -= [self.display.text floatValue];
            break;
        case MRECALL:
            self.display.text = [NSString stringWithFormat:@"%g", self.memory];
            break;
        case MCLEAR:
            self.memory = 0;
            break;
        default:
            break;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self.delegate.history.tape count] < tableLines){
        tableView.frame = CGRectMake(self.display.frame.origin.x,
                                     self.display.frame.origin.y - [self.delegate.history.tape count] * cellHeight - 10,
                                     self.display.frame.size.width,
                                     self.delegate.history.tape.count * cellHeight);
        return [self.delegate.history.tape count];
    }
    tableView.frame = CGRectMake(self.display.frame.origin.x,
                                 0,
                                 self.display.frame.size.width,
                                 self.display.frame.origin.y - 10);
    return tableLines;
}

- (void)goToBottom{
    CGPoint bottomOffset = CGPointMake(0, self.bottomOfTape.contentSize.height - self.bottomOfTape.bounds.size.height);
    [self.bottomOfTape setContentOffset:bottomOffset animated:NO];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myIdentifier = @"MyReuseIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myIdentifier];
    }
    int offset = 0;
    if([self.delegate.history.tape count] >= tableLines){
        offset = [self.delegate.history.tape count] - tableLines;
    }
    cell.detailTextLabel.text = [self.delegate.history.tape objectAtIndex:[indexPath row] + offset];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Courier New" size:20];
    return cell;
}

- (void) handleDoubleFingerPan: (UIPanGestureRecognizer *) sender {
    CGPoint translate = [sender translationInView:self.view];

    NSLog([NSString stringWithFormat:@"%g %g", translate.x, translate.y]);
    if(translate.y > 60){
        sender.enabled = NO;
        [self.delegate goToCurrentTape];
        
    } else if(translate.y < -60){
        [self.delegate goToSavedTapes];
    }
        //CATransition *transition = [CATransition animation];
        //transition.duration = .4f;
        //transition.type = kCATransitionPush;
        //transition.subtype = kCATransitionFromBottom;
        //[self.navigationController.view.layer addAnimation:transition
                                                    //forKey:kCATransition];
        //SecondViewController *secondViewController = [[SecondViewController alloc] init];
        
        //[self.delegate presentViewController:self.delegate.secondViewController animated:NO completion:NULL];
        //self.tabBarController.selectedIndex = 1;
        //UIView *myView = [[UIView alloc] init];
        //self.view = myView;
    
    
    //if(sender.state == UIGestureRecognizerStateEnded){
    //    newFrame.origin.y = 0;
    //    self. = newFrame;
    //}
}

@end
