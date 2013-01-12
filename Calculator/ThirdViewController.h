//
//  ThirdViewController.h
//  Calculator
//
//  Created by Will Jackson on 1/4/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryArrayDelegate.h"
#import "ThirdDetailViewController.h"

@interface ThirdViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UITableView *listOfSaves;
@property (nonatomic) id<HistoryArrayDelegate> delegate;

@property (nonatomic) UIBarButtonItem *edit;

@property (nonatomic) ThirdDetailViewController *detailViewController;

@end
