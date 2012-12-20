//
//  FirstViewController.m
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import "FirstViewController.h"
#import "HistoricOperation.h"

#define ADD             10
#define SUBTRACT        11
#define MULTIPLY        12
#define DIVIDE          13
#define SOLUTION        14
#define CLEAR           15
#define ALL_CLEAR       16
#define DECIMAL_POINT   17



@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.operationHistory = [[NSMutableArray alloc] init];
    
    self.currentFormula = [[HistoricOperation alloc] init];
    
    self.currentOperand = @0;
    
    [self initButton:self.zeroButton        tag:0];
    [self initButton:self.oneButton         tag:1];
    [self initButton:self.twoButton         tag:2];
    [self initButton:self.threeButton       tag:3];
    [self initButton:self.fourButton        tag:4];
    [self initButton:self.fiveButton        tag:5];
    [self initButton:self.sixButton         tag:6];x    [self initButton:self.sevenButton       tag:7];
    [self initButton:self.eightButton       tag:8];
    [self initButton:self.nineButton        tag:9];
    [self initButton:self.addButton         tag:ADD];
    [self initButton:self.subtractButton    tag:SUBTRACT];
    [self initButton:self.multiplyButton    tag:MULTIPLY];
    [self initButton:self.divideButton      tag:DIVIDE];
    [self initButton:self.equalButton       tag:SOLUTION];
    [self initButton:self.acButton          tag:ALL_CLEAR];
    [self initButton:self.cButton           tag:CLEAR];
    [self initButton:self.decimalButton     tag:DECIMAL_POINT];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initButton:(UIButton*) button tag:(int) tag
{
    [button addTarget:self action:@selector(sendInput:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:tag];
}

- (void)appendToDisplay:(NSString*)nextChar{
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

- (void)clearDisplay{
    self.display.text = @"";
}

- (void)clearHistoryDisplay{
    self.historyDisplay.text = @"";
}

- (void)sendInput:(id)sender
{
    //Check if an operator was the last input
    static BOOL justGotOperator;
    static BOOL clearOnNextInput;

    switch ([sender tag]) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            if(justGotOperator){
                [self clearDisplay];
                clearOnNextInput = false;
            }
            if(clearOnNextInput){
                [self clearDisplay];
                [self clearHistoryDisplay];
                clearOnNextInput = false;
            }
            [self appendToDisplay:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:[sender tag]]]];
            justGotOperator = false;
            break;
        case ADD:
        case SUBTRACT:
        case MULTIPLY:
        case DIVIDE:
            
            if(justGotOperator)         [self.currentFormula removeOperation];
            else                        [self.currentFormula addOperand:[NSNumber numberWithFloat:[self.display.text floatValue]]];
            
            if([sender tag] == ADD)        [self.currentFormula addOperation:@"+"];
            if([sender tag] == SUBTRACT)   [self.currentFormula addOperation:@"-"];
            if([sender tag] == MULTIPLY)   [self.currentFormula addOperation:@"*"];
            if([sender tag] == DIVIDE)     [self.currentFormula addOperation:@"/"];
            
            self.historyDisplay.text = [self.currentFormula toString];
            clearOnNextInput = true;
            justGotOperator = true;
            break;
        case SOLUTION:
            if(justGotOperator)
                break;
            [self.currentFormula addOperand:[NSNumber numberWithFloat:[self.display.text floatValue]]];
            self.display.text = [self.currentFormula evaluate];
            self.historyDisplay.text = [self.currentFormula toString];
            [self.operationHistory addObject:self.currentFormula];
            self.currentFormula = [[HistoricOperation alloc] init];
            clearOnNextInput = true;
            break;
        case ALL_CLEAR:
            self.currentFormula = [[HistoricOperation alloc] init];
            self.display.text = @"0";
            self.historyDisplay.text = @"";
            break;
        case CLEAR:
            if(!justGotOperator){
                self.display.text = @"0";
                self.historyDisplay.text = [self.currentFormula toString];
            }
            break;
        case DECIMAL_POINT:
            if(clearOnNextInput){
                [self clearDisplay];
                [self clearHistoryDisplay];
                clearOnNextInput = false;
            }
            if([self.display.text rangeOfString:@"."].location == NSNotFound){
                [self appendToDisplay:@"."];
            }
            break;
        default:
            break;
    }
}

@end
