//
//  ISMServiceEntryLoader.h
//  Salmon
//
//  Created by 周正炎 on 2018/12/10.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SMServiceEntryConfig;

/**
 * 服务入口加载器？
 */
@protocol ISMServiceEntryLoader <NSObject>

@required

- (SMServiceEntryConfig*)loadSMServiceEntryConfig;

@end

NS_ASSUME_NONNULL_END
