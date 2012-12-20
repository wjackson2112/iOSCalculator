//
//  FirstViewController.h
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoricOperation.h"

@interface FirstViewController : UIViewController

@property (nonatomic) IBOutlet UIButton *zeroButton;
@property (nonatomic) IBOutlet UIButton *oneButton;
@property (nonatomic) IBOutlet UIButton *twoButton;
@property (nonatomic) IBOutlet UIButton *threeButton;
@property (nonatomic) IBOutlet UIButton *fourButton;
@property (nonatomic) IBOutlet UIButton *fiveButton;
@property (nonatomic) IBOutlet UIButton *sixButton;
@property (nonatomic) IBOutlet UIButton *sevenButton;
@property (nonatomic) IBOutlet UIButton *eightButton;
@property (nonatomic) IBOutlet UIButton *nineButton;
@property (nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic) IBOutlet UIButton *subtractButton;
@property (nonatomic) IBOutlet UIButton *multiplyButton;
@property (nonatomic) IBOutlet UIButton *divideButton;
@property (nonatomic) IBOutlet UIButton *equalButton;
@property (nonatomic) IBOutlet UIButton *acButton;
@property (nonatomic) IBOutlet UIButton *cButton;
@property (nonatomic) IBOutlet UIButton *decimalButton;

@property (nonatomic) IBOutlet UILabel *display;
@property (nonatomic) IBOutlet UILabel *historyDisplay;

@property (nonatomic) NSMutableArray *operationHistory;

@property (nonatomic) NSNumber *currentOperand;
@property (nonatomic) HistoricOperation *currentFormula;

- (void) initButton:(UIButton*) button tag:(int) tag;

@end
