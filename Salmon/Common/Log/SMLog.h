//
//  SMLog.h
//  Salmon
//
//  Created by 周正炎 on 2018/12/4.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMLogProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#define SM_LOG_INTERNAL(level, moduleName, formatStr, ...)  \
do { \
if ([SMLog shouldLog:level]) { \
[SMLog logWithLevel:level module:moduleName fileName:__FILE__ lineNum:__LINE__ funcName:__FUNCTION__ format:(formatStr), ##__VA_ARGS__]; \
} \
} while(0)

#define SM_LOG_SIMPLE_INTERNAL(level, moduleName, formatStr, ...)  \
do { \
if ([SMLog shouldLog:level]) { \
[SMLog logWithLevel:level module:moduleName format:(formatStr), ##__VA_ARGS__]; \
} \
} while(0)

#define SM_LOG_IMMEDIATELY_INTERNAL(level, moduleName, formatStr, ...)  \
do { \
if ([SMLog shouldLog:level]) { \
[SMLog logImmediatelyWithLevel:level module:moduleName fileName:__FILE__ lineNum:__LINE__ funcName:__FUNCTION__ format:(formatStr), ##__VA_ARGS__]; \
} \
} while(0)



@interface SMLog : NSObject

/**
 *  初始化 Log 模块
 *  @param isDebugMode   是否 Debug 模式
 *  @param logParentPath log存储路径，如果传nil，则存储到/Library/Cache
 *  @param logFileByteSize 文件大小，单位是 Byte
 */
+ (void)prepareForLogging:(BOOL)isDebugMode logParentPath:(NSString *)logParentPath logFileByteSize:(uint64_t)logFileByteSize;

/**
 *  卸载 Log 模块
 *
 */
+ (void)unloadLog;

/**
 *  Log 文件全路径
 *
 *  @return 路径名
 */
+ (NSString *)logFolderPath;


/**
 最新的log文件的完整路径
 
 @return log文件完整路径
 */
+ (NSString *)lastLogFilePathName;

/**
 *  根据指定的级别、格式打 Log。使用默认的 module、context(KWSLogContextDefault)。
 *  为了自定义logerror的方式，避免ddlog在主线程打logerror。
 *
 *  @param logLevel   Log 级别
 *  @param message 格式字符串
 */
+ (void)logWithLevel:(SMLogLevel)logLevel module:(NSString *)module fileName:(const char *)fileName lineNum:(int32_t)lineNum funcName:(const char *)funcName message:(NSString *)message;

+ (void)logWithLevel:(SMLogLevel)logLevel module:(NSString *)module fileName:(const char *)fileName lineNum:(int32_t)lineNum funcName:(const char *)funcName format:(NSString *)format, ... NS_FORMAT_FUNCTION(6,7);

/**
 这个方法不打印文件名、方法名、行数
 */
+ (void)logWithLevel:(SMLogLevel)logLevel module:(NSString *)module format:(NSString *)format, ... NS_FORMAT_FUNCTION(3,4);

/**
 * 同步写 log
 */
+ (void)logImmediatelyWithLevel:(SMLogLevel)logLevel module:(NSString *)module fileName:(const char *)fileName lineNum:(int32_t)lineNum funcName:(const char *)funcName format:(NSString *)format, ... NS_FORMAT_FUNCTION(6,7);

+ (BOOL)shouldLog:(SMLogLevel)level;

+ (void)flush;

@end

NS_ASSUME_NONNULL_END
