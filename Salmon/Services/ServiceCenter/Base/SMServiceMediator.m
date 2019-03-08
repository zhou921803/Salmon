//
//  SMServiceMediator.m
//  Salmon
//
//  Created by 周正炎 on 2018/12/30.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import "SMServiceMediator.h"
#import "SMServiceCenter.h"
#import "SMPlistEntrtyLoader.h"

@implementation SMServiceConfig
@end


@implementation SMServiceMediator

+ (void)setupWithConfig:(SMServiceConfig*)config
{
    //配置里面有 entryLoader
    if (config.customEntryLoader) {
        [[SMServiceCenter sharedObject] registerLoader:config.customEntryLoader];
    }
    
    //没有自定义的entrylLoader，但是配置里面有 services plist 配置文件
    if (config.servicesPlistPath) {
        SMPlistEntrtyLoader* plistLoader = [[SMPlistEntrtyLoader alloc] init];
        plistLoader.filePath = config.servicesPlistPath;
        plistLoader.enableMock = config.enableMock;
        [[SMServiceCenter sharedObject] registerLoader:plistLoader];
    }
    
    [SMServiceMediator loadServices:config.launchServices];
    
    if (config.delayLaunchServices && config.delayLaunchServices.count) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SMServiceMediator loadServices:config.delayLaunchServices];
        });
    }
    
    if (config.secondaryDelayLaunchServices && config.secondaryDelayLaunchServices.count) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SMServiceMediator loadServices:config.secondaryDelayLaunchServices];
        });
    }
}

+ (void)loadServices:(NSArray<Protocol*>*)services
{
    for (NSInteger i = 0; i < services.count; i++) {
        Protocol* proto = [services objectAtIndex:i];
        if (proto != NULL) {
            [SMServiceCenter service:proto];
        }
    }
}

@end
