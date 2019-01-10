//
//  SMServiceCenter.m
//  Salmon
//  服务中心，单例类
//  Created by 周正炎 on 2018/12/10.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import "SMServiceCenter.h"
#import "SMServiceManager.h"
#import "ISMServiceEntryLoader.h"

@interface SMServiceCenter()

@property(nonatomic,strong) SMServiceManager* serviceManager;

@end

@implementation SMServiceCenter

SINGLETON_DEF(SMServiceCenter);

+ (id<ISMServiceManager>)sharedManager
{
    return [SMServiceCenter sharedObject].serviceManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _serviceManager = [[SMServiceManager alloc] init];
    }
    return self;
}

- (id)serviceWithProtocol:(Protocol *)protocol
{
    return [_serviceManager serviceWithProtocol:protocol];
}

- (void)registerLoader:(id<ISMServiceEntryLoader>)loader
{
    [self startLoader:loader];
}

- (void)unregisterLoader:(id<ISMServiceEntryLoader>)loader
{
    [self stopLoader:loader];
}

#pragma mark - loader

- (void)startLoader:(id<ISMServiceEntryLoader>)loader
{
    SMServiceEntryConfig* config = [loader loadSMServiceEntryConfig];
    
    if (config) {
        for (SMServiceEntry* entry in config.entrys) {
            if (entry.type == SMServiceEntryTypeShareObject) {
                [self.serviceManager registerService:entry.cls toProtocol:entry.protocol];
            }  else {
                SMLogError(@"not supposed type");
            }
        }
    }
}

- (void)stopLoader:(id<ISMServiceEntryLoader>)loader
{
    SMServiceEntryConfig* config = [loader loadSMServiceEntryConfig];
    
    if (config) {
        for (SMServiceEntry* entry in config.entrys) {
            if (entry.type == SMServiceEntryTypeShareObject) {
                [self.serviceManager unregisterService:entry.protocol];
            } else {
                SMLogError(@"not supposed type");
            }
        }
    }
    
}

- (id)objectForKeyedSubscript:(Protocol*)key
{
    return [self serviceWithProtocol:key];
}

#pragma mark - convinient

+ (id)service:(Protocol*)protocl
{
    return [[self sharedObject] serviceWithProtocol:protocl];
}

@end
