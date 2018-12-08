//
//  AppDelegate.h
//  Salmon
//
//  Created by 周正炎 on 2018/11/7.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedObject;
@end

