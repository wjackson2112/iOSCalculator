//
//  SecondViewController.h
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoricOperation.h"
#import "FirstViewController.h"

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UITableView *historyListView;
@property (nonatomic) FirstViewController* firstViewController;

- (void)updateOperationHistory:(NSMutableArray*)newOperationHistory;

@end
