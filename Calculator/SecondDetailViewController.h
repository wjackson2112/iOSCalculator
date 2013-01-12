//
//  SecondDetailViewController.h
//  TapeCalc
//
//  Created by Will Jackson on 1/10/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "History.h"
#import "HistoryArrayDelegate.h"

@interface SecondDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic) History *referencedHistory;
@property (nonatomic) int referencedTapeLine;
@property (nonatomic) BOOL cellSelected;

@property (nonatomic) UITextField *editThisLine;

@end
