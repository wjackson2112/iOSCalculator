//
//  ThirdDisclosureViewController.h
//  Calculator
//
//  Created by Will Jackson on 1/8/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryArrayDelegate.h"
#import "History.h"

@interface ThirdDisclosureViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic) int referencedHistoryIndex;

@property (nonatomic) UITextField *name;
@property (nonatomic) UIBarButtonItem *done;

@property (nonatomic) id<HistoryArrayDelegate> delegate;

@property (nonatomic) UIToolbar *toolbar;

@end
