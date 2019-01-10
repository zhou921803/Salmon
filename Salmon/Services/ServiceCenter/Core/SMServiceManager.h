//
//  SMServiceManager.h
//  Salmon
//
//  Created by 周正炎 on 2018/12/10.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMServiceTypes.h"

NS_ASSUME_NONNULL_BEGIN

/*
 * 负责service的创建与映射管理，不负责加载逻辑
 * thread safe
 */
@interface SMServiceManager : NSObject<ISMServiceManager>

@end

NS_ASSUME_NONNULL_END
