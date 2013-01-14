//
//  AppDelegate.h
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "HistoryArrayDelegate.h"
#import "AppViewSwitcher.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

#import "History.h"
#import "HistoricOperation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, HistoryArrayDelegate, AppViewSwitcher>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) NSString *path;

//@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, retain) History* history;
@property (nonatomic, retain) NSMutableArray* savedHistories;

@property (nonatomic, strong) UINavigationController *navController;

@property (nonatomic) FirstViewController *firstViewController;
@property (nonatomic) SecondViewController *secondViewController;
@property (nonatomic) ThirdViewController *thirdViewController;

@end
