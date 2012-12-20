//
//  AppDelegate.h
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoricOperation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
