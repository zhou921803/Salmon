//
//  SMTestModule.m
//  Salmon
//
//  Created by 周正炎 on 2019/3/8.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import "SMTestModule.h"


@implementation SMTestModule

RCT_EXPORT_MODULE()

+ (instancetype)alloc
{
    return [super alloc];
}

RCT_REMAP_METHOD(justGo,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    return;
}

@end
