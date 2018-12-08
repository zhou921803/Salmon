//
//  SMLogProtocol.h
//  Salmon
//
//  Created by 周正炎 on 2018/12/4.
//  Copyright © 2018 周正炎. All rights reserved.
//

#ifndef SMLogProtocol_h
#define SMLogProtocol_h

typedef enum {
    SMLogLevelAll = 0,
    SMLogLevelVerbose = 0,
    SMLogLevelDebug,    // Detailed information on the flow through the system.
    SMLogLevelInfo,     // Interesting runtime events (startup/shutdown), should be conservative and keep to a minimum.
    SMLogLevelWarn,     // Other runtime situations that are undesirable or unexpected, but not necessarily "wrong".
    SMLogLevelError,    // Other runtime errors or unexpected conditions.
    SMLogLevelFatal,    // Severe errors that cause premature termination.
    SMLogLevelNone,     // Special level used to disable all log messages.
} SMLogLevel;


@protocol ISMLogImplProtocol <NSObject>


/**
 @param isDebugMode 是否是debug模式
 @param logParentPath log父目录，如果传nil则默认存到/Library/Cache下
 @param logFileByteSize 文件大小，单位是 Byte
 */
- (void)prepareForLogging:(BOOL)isDebugMode logParentPath:(NSString *)logParentPath logFileByteSize:(uint64_t)logFileByteSize;

- (void)unloadLog;

- (NSString *)logFolderPath;

/**
 返回最新的log文件的完整路径
 
 @return 文件的完整路径
 */
- (NSString *)lastLogFilePathName;

/**
 * 在异步队列里写 log
 */
- (void)logWithLevel:(SMLogLevel)logLevel moduleName:(NSString *)moduleName fileName:(const char *)fileName lineNumber:(int)lineNumber funcName:(const char *)funcName message:(NSString *)message;

/**
 * 立即写 log
 */
- (void)logImmediatelyWithLevel:(SMLogLevel)logLevel moduleName:(NSString *)moduleName fileName:(const char *)fileName lineNumber:(int)lineNumber funcName:(const char *)funcName message:(NSString *)message;

- (BOOL)shouldLog:(SMLogLevel)level;

- (void)flush;

@end



#endif /* SMLogProtocol_h */
