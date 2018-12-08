//
//  SMStartupManager.h
//  Salmon
//
//  Created by 周正炎 on 2018/11/30.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMStartupManager : NSObject

SINGLETON_DEC(SMStartupManager);

- (void)setupBeforeLaunch;

- (void)setupWithOptions:(NSDictionary *)launchOptions;

- (void)setupWhenRootViewDidAppear;

- (void)setupDelayTasks;

@end

NS_ASSUME_NONNULL_END
