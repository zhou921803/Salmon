//
//  SMStartupManager.m
//  Salmon
//
//  Created by 周正炎 on 2018/11/30.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Bugly/Bugly.h>
#import "SMStartupManager.h"
#import "SMServiceMediator.h"
@implementation SMStartupManager

SINGLETON_DEF(SMStartupManager);

/**
 * app启动前操作
 */
- (void)setupBeforeLaunch
{
    //Bugly 初始化
    [Bugly startWithAppId:@"822289e49c"];
    
    //启动服务
    [SMStartupManager setupServices];
}

/**
 * 根据启动参数启动app
 */
- (void)setupWithOptions:(NSDictionary *)launchOptions
{
    
}


/**
 * 开启启动所有services服务
 */
+ (void)setupServices
{
    SMLogInfo(@"{Start} >> Setup Services");
    //读取服务配置文件，根据配置文件启动服务
    SMServiceConfig *config = [[SMServiceConfig alloc] init];
    config.enableMock = NO;
    config.servicesPlistPath = [[NSBundle mainBundle] pathForResource:@"SMServices" ofType:@"plist"];
    [SMServiceMediator setupWithConfig:config];
    
    SMLogInfo(@"{End} >> SetupServices");
}

@end
