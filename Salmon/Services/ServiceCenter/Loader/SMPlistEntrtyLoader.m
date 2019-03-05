//
//  SMPlistEntrtyLoader.m
//  Salmon
//
//  Created by 周正炎 on 2019/1/15.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import "SMPlistEntrtyLoader.h"

@implementation SMPlistEntrtyLoader

- (SMServiceEntryConfig*)loadSMServiceEntryConfig
{
    if (!self.filePath) {
        return nil;
    }
    
    NSArray *serviceList = [[NSArray alloc] initWithContentsOfFile:self.filePath];
    
    if (!serviceList) {
        return nil;
    }
    
    HYServiceEntryConfig* config = [[HYServiceEntryConfig alloc] init];
    NSMutableArray* entryList = [NSMutableArray arrayWithCapacity:serviceList.count];
    
    for (NSDictionary* dict in serviceList) {
        NSString* clsStr = [dict objectForKey:kEntryImplKey];
        
        if ([VersionHelper isInternalVersion]) {
            if (self.enableMock) {
                NSString* mockClsStr = [dict objectForKey:kEntryMockImplKey];
                
                if (mockClsStr && mockClsStr.length) {
                    clsStr = mockClsStr;
                }
            }
        }
        
        NSString* protocolStr = [dict objectForKey:kEntryProtocolKey];
        
        if (clsStr && protocolStr) {
            Class cls = NSClassFromString(clsStr);
            Protocol* protocol = NSProtocolFromString(protocolStr);
            
            if (cls && protocol != NULL) {
                
                HYServiceEntryType type = HYServiceEntryTypeShareObject;
                HYServiceEntry* entry = [[HYServiceEntry alloc] initWithClass:cls protocol:protocol type:type];
                [entryList addObject:entry];
            }
            
        }
    }
    
    config.entrys = entryList;
    return config;
}

@end
