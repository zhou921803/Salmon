//
//  MSFilePath.h
//  Salmon
//  通用业务无关的文件操作
//  Created by 周正炎 on 2018/12/5.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSFilePath : NSObject

#pragma mark - File manager methods
+ (NSFileManager *)fileManager;
+ (BOOL)isPathExist:(NSString *)path;
+ (BOOL)isFileExist:(NSString *)path;
+ (BOOL)isDirectoryExist:(NSString *)path;
+ (BOOL)removeFile:(NSString *)path;
+ (BOOL)createPath:(NSString *)path;
+ (NSUInteger)fileCountInPath:(NSString *)path;
+ (unsigned long long)folderSizeAtPath:(NSString *)path;

#pragma mark - User directory methods

+ (NSString *)appDocumentPath;
+ (NSString *)appSupportPathForThisApp;
+ (NSString *)appResourcePath;
+ (NSString *)appCachePath;
+ (NSString *)appStorageCachePath;

@end

NS_ASSUME_NONNULL_END
