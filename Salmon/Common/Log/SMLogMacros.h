//
//  SMLogMacros.h
//  Salmon
//
//  Created by 周正炎 on 2018/12/5.
//  Copyright © 2018 周正炎. All rights reserved.
//
#ifndef SMLogMacros_h
#define SMLogMacros_h

#import <Foundation/Foundation.h>
#import "SMLog.h"

#define SM_LOG_MACRO(level, moduleName, format, ...) \
SM_LOG_INTERNAL(level, moduleName, format, ##__VA_ARGS__)

#define SM_LOG_IMMEDIATELY_MACRO(level, moduleName, format, ...) \
SM_LOG_IMMEDIATELY_INTERNAL(level, moduleName, format, ##__VA_ARGS__)

#define SM_LOG_ERROR(module, format, ...) SM_LOG_MACRO(SMLogLevelError, module, format, ##__VA_ARGS__)
#define SM_LOG_WARNING(module, format, ...) SM_LOG_MACRO(SMLogLevelWarn, module, format, ##__VA_ARGS__)
#define SM_LOG_INFO(module, format, ...) SM_LOG_MACRO(SMLogLevelInfo, module, format, ##__VA_ARGS__)
#define SM_LOG_DEBUG(module, format, ...) SM_LOG_MACRO(SMLogLevelDebug, module, format, ##__VA_ARGS__)

// 模块区分
#define kDefaultModule @"SM-Default"
//#define kChargeModule  @"SM-Charge"
//#define kMediaModule   @"SM-Media"
//#define kWebModule     @"SM-Web"
//#define kSMSDKModule   @"SMSDK"
//#define kVideoModule   @"SM-Video"


//默认模块
#define SMLogError(frmt, ...)  \
SM_LOG_ERROR(kDefaultModule, frmt, ##__VA_ARGS__)

#define SMLogWarn(frmt, ...)  \
SM_LOG_WARNING(kDefaultModule, frmt, ##__VA_ARGS__)

#define SMLogInfo(frmt, ...)  \
SM_LOG_INFO(kDefaultModule, frmt, ##__VA_ARGS__)

#define SMLogDebug(frmt, ...)  \
SM_LOG_DEBUG(kDefaultModule, frmt, ##__VA_ARGS__)

#define SM_LOG_INIT(isDebug, logDir, logSize) [SMLog prepareForLogging:isDebug logParentPath:logDir logFileByteSize:logSize];


#endif /* SMLogMacros_h */
