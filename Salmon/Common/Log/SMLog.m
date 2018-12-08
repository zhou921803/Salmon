//
//  SMLog.m
//  Salmon
//
//  Created by 周正炎 on 2018/12/4.
//  Copyright © 2018 周正炎. All rights reserved.
//


#import "SMLog.h"
#import "LogMarsImp.h"

static id<ISMLogImplProtocol> _logImpl = nil;

@implementation SMLog

#pragma mark - Public

+ (void)prepareForLogging:(BOOL)needConsoleLog logParentPath:(NSString *)logParentPath logFileByteSize:(uint64_t)logFileByteSize
{
    _logImpl = [LogMarsImp new];
    
    [_logImpl prepareForLogging:needConsoleLog logParentPath:logParentPath logFileByteSize:logFileByteSize];
    
    ////prepareForLogging is called when app is in start-up pharse, to avoid slow start-up pharse,
    //putting cleanLogFiles to aysnc call in main thread
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [SMLog cleanLogFiles];
    });
}

+ (void)unloadLog
{
    [_logImpl unloadLog];
}


+ (NSString *)logFolderPath
{
    return [_logImpl logFolderPath];
}

+ (void)logWithLevel:(SMLogLevel)logLevel module:(NSString *)module fileName:(const char*)fileName lineNum:(int32_t)lineNum funcName:(const char*)funcName message:(NSString *)message
{
    [_logImpl logWithLevel:logLevel moduleName:module fileName:fileName lineNumber:lineNum funcName:funcName message:message];
}

+ (void)logWithLevel:(SMLogLevel)logLevel module:(NSString *)module fileName:(const char*)fileName lineNum:(int32_t)lineNum funcName:(const char*)funcName format:(NSString *)format, ...
{
    va_list argList;
    va_start(argList, format);
    NSString* message = [[NSString alloc] initWithFormat:format arguments:argList];
    va_end(argList);
    
    [_logImpl logWithLevel:logLevel moduleName:module fileName:fileName lineNumber:lineNum funcName:funcName message:message];
}

+ (void)logWithLevel:(SMLogLevel)logLevel module:(NSString *)module format:(NSString *)format, ...
{
    va_list argList;
    va_start(argList, format);
    NSString* message = [[NSString alloc] initWithFormat:format arguments:argList];
    va_end(argList);
    
    [_logImpl logWithLevel:logLevel moduleName:module fileName:"" lineNumber:0 funcName:"" message:message];
}

+ (void)logImmediatelyWithLevel:(SMLogLevel)logLevel module:(NSString *)module fileName:(const char *)fileName lineNum:(int32_t)lineNum funcName:(const char *)funcName format:(NSString *)format, ... NS_FORMAT_FUNCTION(6,7)
{
    va_list argList;
    va_start(argList, format);
    NSString* message = [[NSString alloc] initWithFormat:format arguments:argList];
    va_end(argList);
    
    [_logImpl logImmediatelyWithLevel:logLevel moduleName:module fileName:fileName lineNumber:lineNum funcName:funcName message:message];
}

+ (BOOL)shouldLog:(SMLogLevel)level
{
    return [_logImpl shouldLog:level];
}

+ (void)flush
{
    [_logImpl flush];
}

#pragma mark - private

+ (void)cleanLogFiles
{
    NSError* error= nil;
    NSString* logFolder = [SMLog logFolderPath];
    NSArray* logFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logFolder error:&error];
    if (logFiles == nil || [logFiles count] == 0) {
        SMLogError(@"Error happened when clearnLogFiles:%@", error);
        return;
    }
    
#ifdef DEBUG
    NSDate* date = [[NSDate date] dateByAddingTimeInterval:-10*24*60*60];
#else
    NSDate* date = [[NSDate date] dateByAddingTimeInterval:-7*24*60*60];
#endif
    
    for (NSString *logFile in logFiles) {
        
        NSString *logFilePath = [logFolder stringByAppendingPathComponent:logFile];
        NSDictionary *fileAttr = [[NSFileManager defaultManager] attributesOfItemAtPath:logFilePath error:&error];
        if (fileAttr) {
            NSDate *creationDate = [fileAttr valueForKey:NSFileCreationDate];
            if ([creationDate compare:date] == NSOrderedAscending) {
                SMLogInfo(@"[Kiwi:LogExt] cleanLogFiles: %@ will be deleted", logFile);
                [[NSFileManager defaultManager] removeItemAtPath:logFilePath error:&error];
                SMLogInfo(@"[Kiwi:LogExt] cleanLogFiles: %@ was deleted, error number is %ld", logFilePath, (long)error.code);
            }
        }
    }
}

+ (NSString *)lastLogFilePathName
{
    return [_logImpl lastLogFilePathName];
}


@end
