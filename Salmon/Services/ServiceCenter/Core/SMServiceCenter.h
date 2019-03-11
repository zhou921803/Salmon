//
//  SMServiceCenter.h
//  Salmon
//
//  Created by 周正炎 on 2018/12/10.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SMServiceTypes.h"
#import "ISMServiceEntryLoader.h"

NS_ASSUME_NONNULL_BEGIN

#define SMService(procol)     ((NSObject<procol> *)[SMServiceCenter service:@protocol(procol)])

@interface SMServiceCenter : NSObject

SINGLETON_DEC(SMServiceCenter);

+ (id<ISMServiceManager>)sharedManager;

- (id<ISMServiceManager>)serviceManager;

- (void)registerLoader:(id<ISMServiceEntryLoader>)loader;

- (void)unregisterLoader:(id<ISMServiceEntryLoader>)loader;

- (id)objectForKeyedSubscript:(Protocol*)key;

#pragma mark - convinient

+ (id)service:(Protocol*)protocl;

@end

NS_ASSUME_NONNULL_END
