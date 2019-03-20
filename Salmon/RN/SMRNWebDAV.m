//
//  SMTestModule.m
//  Salmon
//
//  Created by 周正炎 on 2019/3/8.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import <React/RCTConvert.h>
#import "SMRNWebDAV.h"
#import "ISMWebDAVProtocol.h"

@implementation SMRNWebDAV

RCT_EXPORT_MODULE()

+ (instancetype)alloc
{
    return [super alloc];
    
}

RCT_EXPORT_METHOD(configDAV:(NSDictionary*)params)
{
//    NSString *root=@"https://dav.jianguoyun.com/dav";
//    NSString *user=@"zhou921803@163.com";
//    NSString *password=@"axwdkcia37x6j4ed";
    
    
    NSString *root = [RCTConvert NSString:params[@"root"]];
    NSString *user = [RCTConvert NSString:params[@"user"]];
    NSString *password = [RCTConvert NSString:params[@"password"]];
    NSString *localMappingPath = [RCTConvert NSString:params[@"localMappingPath"]];
    [SMService(ISMWebDAVProtocol) configClientWith:root userName:user passWord:password localMappingPath:localMappingPath];
    return;
}

RCT_EXPORT_METHOD(getPathProperty:(NSString*)subPath
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [SMService(ISMWebDAVProtocol) getPathProperty:subPath completion:^(NSError *error, NSArray<ISMWebDAVItem> *items) {
        if(error){
            reject(@"", @"", error);
        } else {
            NSMutableArray *davItems = [[NSMutableArray alloc] initWithCapacity:5];
            
            for(NSUInteger index = 0; index < items.count; ++index){
                [davItems addObject:[items[index] toJsonString]];
            }
            
            resolve(davItems);
        }
    }];
    return;
}

@end
