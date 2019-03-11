//
//  SMNetSyncManager.h
//  Salmon
//
//  Created by 周正炎 on 2019/3/8.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISMNetSyncProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMNetSyncManager : NSObject<ISMNetSyncProtocol>

SINGLETON_DEC(SMNetSyncManager)

@end

NS_ASSUME_NONNULL_END
