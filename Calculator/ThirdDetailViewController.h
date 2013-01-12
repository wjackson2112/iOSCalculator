//
//  ThirdDetailViewController.h
//  Calculator
//
//  Created by Will Jackson on 1/6/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryArrayDelegate.h"
#import "History.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SecondDetailViewController.h"

@interface ThirdDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic) IBOutlet UITableView *historyListView;
@property (nonatomic) UIBarButtonItem *mail;
@property (nonatomic) int referencedHistoryIndex;
@property (nonatomic) History *referencedHistory;

@property (nonatomic) SecondDetailViewController *detailViewController;

@property (nonatomic) MFMailComposeViewController *mailViewController;

@property (nonatomic) id<HistoryArrayDelegate> delegate;

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;

@end
