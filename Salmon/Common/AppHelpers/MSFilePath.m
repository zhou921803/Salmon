//
//  MSFilePath.m
//  Salmon
//
//  Created by 周正炎 on 2018/12/5.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import "MSFilePath.h"

@implementation MSFilePath

#pragma mark File manager methods

+ (NSFileManager *)fileManager
{
    return [NSFileManager defaultManager];
}

+ (BOOL)isPathExist:(NSString *)path
{
    SMLogInfo(@"path: %@", path);
    return [[self fileManager] fileExistsAtPath:path];
}

+ (BOOL)isFileExist:(NSString *)path
{
    SMLogInfo(@"path: %@", path);
    BOOL isDirectory;
    return [[self fileManager] fileExistsAtPath:path isDirectory:&isDirectory] && !isDirectory;
}

+ (BOOL)isDirectoryExist:(NSString *)path
{
    SMLogInfo(@"path: %@", path);
    BOOL isDirectory;
    return [[self fileManager] fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory;
}

+ (BOOL)removeFile:(NSString *)path
{
    SMLogInfo(@"path: %@", path);
    return [[self fileManager] removeItemAtPath:path error:nil];
}

+ (BOOL)createPath:(NSString *)path
{
    SMLogInfo(@"path: %@", path);
    return [[self fileManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (NSUInteger)fileCountInPath:(NSString *)path
{
    SMLogInfo(@"path: %@", path);
    NSUInteger count = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:path];
    for (__unused NSString *fileName in fileEnumerator) {
        count += 1;
    }
    return count;
}

+ (unsigned long long)folderSizeAtPath:(NSString *)path
{
    SMLogInfo(@"path: %@", path);
    __block unsigned long long totalFileSize = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:path];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        NSDictionary *fileAttrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        totalFileSize += fileAttrs.fileSize;
    }
    return totalFileSize;
}


#pragma mark User directory methods

+ (NSString *)appDocumentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)appSupportPathForThisApp
{
    return [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"ThisApp"];
}

+ (NSString *)appResourcePath
{
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)appCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)appStorageCachePath
{
    return [[self appSupportPathForThisApp] stringByAppendingPathComponent:@"Storages"];
}
@end
