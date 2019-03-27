//
//  SMRNWebServer.m
//  Salmon
//
//  Created by 周正炎 on 2019/3/27.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import "SMRNWebServer.h"
#import <GCDWebServer/GCDWebServer.h>

@interface SMRNWebServer()

@property(nonatomic, strong) GCDWebServer *webServer;


@end

@implementation SMRNWebServer

RCT_EXPORT_MODULE()


/**
 * 开启服务
 */
RCT_EXPORT_METHOD(startServerAt:(NSString*)localPath)
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopWebServer];
        
        self.webServer = [[GCDWebServer alloc] init];
        
        [self.webServer addGETHandlerForBasePath:@"/"
                                   directoryPath:localPath
                                   indexFilename:nil
                                        cacheAge:2600
                              allowRangeRequests:YES];
        
        [self.webServer startWithPort:9090 bonjourName:nil];
    });
    
}

/**
 * 关闭服务
 */
RCT_EXPORT_METHOD(stopServer)
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [self stopWebServer];
    });
}


- (void)stopWebServer
{
    if(self.webServer){
        [self.webServer stop];
    }
}



@end
