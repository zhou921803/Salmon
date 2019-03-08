//
//  SMPlistEntrtyLoader.m
//  Salmon
//
//  Created by 周正炎 on 2019/1/15.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import "SMPlistEntrtyLoader.h"
#import "SMServiceTypes.h"

static NSString* kEntryImplKey     = @"impl";
static NSString* kEntryMockImplKey = @"mockImpl";
static NSString* kEntryProtocolKey = @"protocol";
static NSString* kEntryTypeKey     = @"type";

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
    
    SMServiceEntryConfig* config = [[SMServiceEntryConfig alloc] init];
    NSMutableArray* entryList = [NSMutableArray arrayWithCapacity:serviceList.count];
    
    for (NSDictionary* dict in serviceList) {
        NSString* clsStr = [dict objectForKey:kEntryImplKey];
        
//        if ([VersionHelper isInternalVersion]) {
//            if (self.enableMock) {
//                NSString* mockClsStr = [dict objectForKey:kEntryMockImplKey];
//                
//                if (mockClsStr && mockClsStr.length) {
//                    clsStr = mockClsStr;
//                }
//            }
//        }
        
        NSString* protocolStr = [dict objectForKey:kEntryProtocolKey];
        
        if (clsStr && protocolStr) {
            Class cls = NSClassFromString(clsStr);
            Protocol* protocol = NSProtocolFromString(protocolStr);
            
            if (cls && protocol != NULL) {
                
                SMServiceEntryType type = SMServiceEntryTypeShareObject;
                SMServiceEntry* entry = [[SMServiceEntry alloc] initWithClass:cls protocol:protocol type:type];
                [entryList addObject:entry];
            }
            
        }
    }
    
    config.entrys = entryList;
    return config;
}

@end
