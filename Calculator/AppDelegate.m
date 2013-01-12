//
//  AppDelegate.m
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "HistoricOperation.h"

#define kHistoriesKey @"Histories"
#define kCurrentHistoryKey @"History"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    FirstViewController *viewController1;
    SecondViewController *viewController2;
    ThirdViewController *viewController3;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPhone" bundle:nil];
        viewController3 = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil];
    } else {
        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];
        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPad" bundle:nil];
    }
    
    //self.navController = [[UINavigationController alloc] initWithRootViewController:self.firstViewController];
    UINavigationController *navViewController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    UINavigationController *navViewController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    UINavigationController *navViewController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    
    viewController1.tabBarItem.image = [UIImage imageNamed:@"Calc.png"];
    viewController2.tabBarItem.image = [UIImage imageNamed:@"Tape.png"];
    viewController3.tabBarItem.image = [UIImage imageNamed:@"Folder.png"];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[navViewController1, navViewController2, navViewController3];
    self.window.rootViewController = self.tabBarController;
    
    //self.window.rootViewController = self.navController;
    
    [self.window makeKeyAndVisible];
    
    self.savedHistories = [[NSMutableArray alloc] init];
    self.history = [[History alloc] init];
    
    
    //Load from property list
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.path = [[path objectAtIndex:0] stringByAppendingPathComponent:@"historySaveFile.plist"];\
    NSError *error;
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    //[fileMgr removeItemAtPath:self.path error:&error];
    NSData *data = [[NSData alloc] initWithContentsOfFile:self.path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    NSMutableArray *theHistories = [[NSMutableArray alloc] init];
    theHistories = [unarchiver decodeObjectForKey:kHistoriesKey];
    History *theHistory = [[History alloc] init];
    theHistory = [unarchiver decodeObjectForKey:kCurrentHistoryKey];
    [unarchiver finishDecoding];
    
    if(theHistories){
        self.savedHistories = theHistories;
    }
    
    if(theHistory){
        self.history = theHistory;
    }
    
    viewController1.delegate = self;
    viewController2.delegate = self;
    viewController3.delegate = self;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.savedHistories forKey:kHistoriesKey];
    [archiver encodeObject:self.history forKey:kCurrentHistoryKey];
    [archiver finishEncoding];
    [data writeToFile:self.path atomically:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}

- (History*) history{
    return _history;
}

- (NSMutableArray*) savedHistories{
    return _savedHistories;
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
