//
//  AppDelegate.m
//  Salmon
//
//  Created by 周正炎 on 2018/11/7.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <React/RCTRootView.h>
#import "AppDelegate.h"

#import "SMStartupManager.h"
#import "SMRootViewController.h"
#import "SMNavigationController.h"
#import "SMMainTabViewController.h"
#import "SMFileBrowserViewController.h"
#import "SMMyfilesViewController.h"
#import "SMSettingOptionViewController.h"
#import "SMNavigationManager.h"
#import "SMWebDAVClient.h"

#define USE_LOCAL_BUNDLE

@interface AppDelegate ()

@property (nonatomic, strong) SMWebDAVClient *client;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    SMLogInfo(@"application:didFinishLaunchingWithOptions");
    
    [SINGLETON_OBJECT(SMStartupManager) setupBeforeLaunch];     //启动前的操作
    [SINGLETON_OBJECT(SMStartupManager) setupWithOptions:launchOptions];
    
    [self setupViewController];
    
//    NSString *root=@"https://dav.jianguoyun.com/dav";
//    NSString *user=@"zhou921803@163.com";
//    NSString *password=@"axwdkcia37x6j4ed";
//
//    self.client = [SMWebDAVClient new];
//    [self.client configClientWith:root userName:user passWord:password localMappingPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
//
//    [self.client getPathProperty:@"/" completion:^(NSError *error, NSArray<ISMWebDAVItem> *items) {
//        if(!error){
//            NSLog(@"items count %lu", (unsigned long)items.count);
//        }
//    }];
//    [self.client downloadFile:@"/我的坚果云/MarkDown/TODO.md" completion:^(NSError *error, NSString *downloadedPath) {
//        //根控制器
//        SMRootViewController *rootViewController = (SMRootViewController *)self.window.rootViewController;
//
//
//        NSURL *jsCodeLocation = [NSURL
//                                 URLWithString:@"http://127.0.0.1:8081/index.ios.bundle?platform=ios"];
//        RCTRootView *rootView =
//        [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
//                             moduleName        : @"RNHighScores"
//                             initialProperties :
//         @{
//           @"scores" : @[
//                   @{
//                       @"name" : @"Alex",
//                       @"value": @"42"
//                       },
//                   @{
//                       @"name" : @"Joel",
//                       @"value": @"10"
//                       }
//                   ],
//           @"filePath":downloadedPath
//           }
//                              launchOptions    : nil];
//        rootView.frame = rootViewController.view.bounds;
//        [rootViewController.view addSubview:rootView];
//    }];
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
    
//    UIView *view = [[UIView alloc] initWithFrame:rootViewController.view.frame];
//    view.backgroundColor = [UIColor grayColor];
    
#ifndef USE_LOCAL_BUNDLE
    NSURL *jsCodeLocation = [NSURL
                             URLWithString:@"http://127.0.0.1:8081/index.ios.bundle?platform=ios"];
#else
    
    NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                         moduleName        : @"SalmonRNApp"
                         initialProperties :
     @{
       
       }
                          launchOptions    : nil];
    rootView.frame = rootViewController.view.bounds;
    [rootViewController.view addSubview:rootView];
    

//    [rootViewController test];
    
//    [rootViewController NSSelectorFromString(@"test")];
    
    
//    SMMainTabViewController *mainTabViewController = [self createMainTabViewControllerContent];
//
//    //navigation控制器
//    SMNavigationController *navigationController = [[SMNavigationController alloc] initWithRootViewController:mainTabViewController];
//
//    [rootViewController addChildViewController:navigationController];
//    navigationController.view.frame = rootViewController.view.bounds;
//    [rootViewController.view addSubview:navigationController.view];
//    [navigationController didMoveToParentViewController:rootViewController];
//
//    [SINGLETON_OBJECT(SMNavigationManager) setupWithNavigationController:navigationController];
}

- (SMMainTabViewController*)createMainTabViewControllerContent
{
    //tabBar控制器
    SMMainTabViewController *mainTabViewController = [[SMMainTabViewController alloc] init];
    
    SMMyfilesViewController *myFilesViewController = [[SMMyfilesViewController alloc] init];
    myFilesViewController.tabBarItem.title = @"我的文件";
    [mainTabViewController addChildViewController:myFilesViewController];
    
    SMSettingOptionViewController *settingOptionViewController = [[SMSettingOptionViewController alloc] init];
    settingOptionViewController.tabBarItem.title = @"设置";
    [mainTabViewController addChildViewController:settingOptionViewController];
    
    return mainTabViewController;
}
@end
