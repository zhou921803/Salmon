//
//  AppDelegate.m
//  Salmon
//
//  Created by 周正炎 on 2018/11/7.
//  Copyright © 2018 周正炎. All rights reserved.
//


#import "AppDelegate.h"

#import "SMStartupManager.h"
#import "SMRootViewController.h"
#import "SMNavigationController.h"
#import "SMMainTabViewController.h"
#import "SMFileBrowserViewController.h"
#import "SMSettingOptionViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    SMLogInfo(@"application:didFinishLaunchingWithOptions");
    
    [SINGLETON_OBJECT(SMStartupManager) setupBeforeLaunch];
    [SINGLETON_OBJECT(SMStartupManager) setupWithOptions:launchOptions];
    
    [self setupViewController];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    SMLogInfo(@"applicationWillResignActive");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    SMLogInfo(@"applicationDidEnterBackground");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    SMLogInfo(@"applicationWillEnterForeground");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    SMLogInfo(@"applicationDidBecomeActive");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    SMLogInfo(@"applicationWillTerminate");
}

#pragma mark - Public

+ (AppDelegate *)sharedObject
{
    return (AppDelegate *)([UIApplication sharedApplication].delegate);
}

#pragma mark - Private
/**
 * 设置ViewController
 */
- (void)setupViewController
{
    //根控制器
    SMRootViewController *rootViewController = (SMRootViewController *)self.window.rootViewController;
    
    SMMainTabViewController *mainTabViewController = [self createMainTabViewControllerContent];

    //navigation控制器
    SMNavigationController *navigationController = [[SMNavigationController alloc] initWithRootViewController:mainTabViewController];
    
    [navigationController willMoveToParentViewController:self.window.rootViewController];
    [self.window.rootViewController addChildViewController:navigationController];
    navigationController.view.frame = rootViewController.view.bounds;
    [rootViewController.view addSubview:navigationController.view];
    [navigationController didMoveToParentViewController:self.window.rootViewController];
    
    
}

- (SMMainTabViewController*)createMainTabViewControllerContent
{
    //tabBar控制器
    SMMainTabViewController *mainTabViewController = [[SMMainTabViewController alloc] init];
    
    SMFileBrowserViewController *fileBrowserViewController = [[SMFileBrowserViewController alloc] init];
    fileBrowserViewController.tabBarItem.title = @"我的文件";
    [mainTabViewController addChildViewController:fileBrowserViewController];
    
    SMSettingOptionViewController *settingOptionViewController = [[SMSettingOptionViewController alloc] init];
    settingOptionViewController.tabBarItem.title = @"设置";
    [mainTabViewController addChildViewController:settingOptionViewController];
    
    return mainTabViewController;
}
@end
