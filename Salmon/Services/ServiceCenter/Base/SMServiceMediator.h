//
//  SMServiceMediator.h
//  Salmon
//
//  Created by 周正炎 on 2018/12/30.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMServiceTypes.h"
#import "ISMServiceEntryLoader.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMServiceConfig : NSObject

//开启mock模式，这样会优先取plist里的mockImpl
@property(nonatomic,assign) BOOL enableMock;

@property(nonatomic,strong) id<ISMServiceEntryLoader> customEntryLoader;
// plist所在的绝对路径
@property(nonatomic,strong) NSString* servicesPlistPath;

//启动项的services，本来想做依赖注入加载的
//考虑到service作为一个服务，粒度比较大，做依赖注入不一定合适，目前项目的使用场景遇到依赖初始化的情况也不多
//暂时集中式管理

//类似cpu cache，只定义一级二级概念，更多级的细分就业务具体自己实现了
//启动时需要加载的services
@property(nonatomic,strong) NSArray<Protocol*>* launchServices;
//一级延迟启动加载的services
@property(nonatomic,strong) NSArray<Protocol*>* delayLaunchServices;
//二级延迟启动加载的services
@property(nonatomic,strong) NSArray<Protocol*>* secondaryDelayLaunchServices;

@end

@interface SMServiceMediator : NSObject

/**
 * 根据文件配置设置
 */
+ (void)setupWithConfig:(SMServiceConfig*)config;

+ (void)loadServices:(NSArray<Protocol*>*)services;

@end

NS_ASSUME_NONNULL_END
