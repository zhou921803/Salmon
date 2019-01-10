//
//  SMServiceTypes.h
//  Salmon
//
//  Created by 周正炎 on 2018/12/10.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISMService.h"

NS_ASSUME_NONNULL_BEGIN


/**
 * 服务管理器协议
 */
@protocol ISMServiceManager<NSObject>

@required

- (BOOL)registerService:(Class)cls toProtocol:(Protocol *)protocol;

- (BOOL)unregisterService:(Protocol *)protocol;

- (id<ISMService>)serviceWithProtocol:(Protocol *)protocol;

- (id)objectForKeyedSubscript:(Protocol*)key;

@end

/**
 * 服务入口类型
 */
typedef enum {
    SMServiceEntryTypeShareObject               //单例
} SMServiceEntryType;


/**
 *  单个服务入口
 */
@interface SMServiceEntry : NSObject
@property(nonatomic,strong,readonly) Class cls;
@property(nonatomic,strong,readonly) Protocol* protocol;
@property(nonatomic,assign,readonly) SMServiceEntryType type;

- (id)initWithClass:(Class)theClass
           protocol:(Protocol *)protocol
               type:(SMServiceEntryType)type;
@end

/**
 *  服务入口配置
 */
@interface SMServiceEntryConfig : NSObject
@property(nonatomic,strong) NSArray<SMServiceEntry*>* entrys;
@end


NS_ASSUME_NONNULL_END
