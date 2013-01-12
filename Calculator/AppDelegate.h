//
//  AppDelegate.h
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoricOperation.h"
#import "HistoryArrayDelegate.h"
#import "FirstViewController.h"
#import "History.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, HistoryArrayDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) NSString *path;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, retain) History* history;
@property (nonatomic, retain) NSMutableArray* savedHistories;

@property (nonatomic, strong) UINavigationController *navController;

@end
