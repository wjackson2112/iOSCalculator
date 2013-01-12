//
//  SecondViewController.h
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoricOperation.h"
#import "HistoryArrayDelegate.h"

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic) IBOutlet UITableView *historyListView;
@property (nonatomic) UIBarButtonItem *clearButton;
@property (nonatomic) UIBarButtonItem *saveButton;

@property (nonatomic) UIPanGestureRecognizer *doubleFingerPan;

@property (nonatomic) id<HistoryArrayDelegate> delegate;


@end
