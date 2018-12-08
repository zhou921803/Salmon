//
//  main.m
//  Salmon
//
//  Created by 周正炎 on 2018/11/7.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MSFilePath.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        //日志初始化
#ifdef DEBUG
        BOOL isDebug = YES;
#else
        BOOL isDebug = NO;
#endif
        NSString *logDir = [MSFilePath appDocumentPath];
        uint64_t logSize = 1024 * 1024 * 3; //2018-05-08 设为 3 MB
        SM_LOG_INIT(isDebug, logDir, logSize);
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
