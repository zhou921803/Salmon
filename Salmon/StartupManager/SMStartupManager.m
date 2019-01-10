//
//  SMStartupManager.m
//  Salmon
//
//  Created by 周正炎 on 2018/11/30.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Bugly/Bugly.h>
#import "SMStartupManager.h"

@implementation SMStartupManager

SINGLETON_DEF(SMStartupManager);

- (void)setupBeforeLaunch
{
    [Bugly startWithAppId:@"822289e49c"];
    
    [SMStartupManager setupServices];
}

- (void)setupWithOptions:(NSDictionary *)launchOptions
{
    
}



+ (void)setupServices
{
    SMLogInfo(@"{Start} >> Setup Services");
    
    
    
    
    SMLogInfo(@"{End} >> SetupServices");
}

@end
