//
//  SMWebDAVClient.h
//  Salmon
//
//  Created by 周正炎 on 2019/3/9.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMWebDAVClient : NSObject

/**
 * 配置WebDAV客户端
 */
- (BOOL)configClientWith:(NSString*)rootUrl
                userName:(NSString*)userName
                passWord:(NSString*)passWord
        localMappingPath:(NSString*)localMappingPath;

/**
 * 文件路径属性获取
 */

- (void)getPathProperty:(NSString*)subPath;

/**
 * 下载文件
 */

- (void)downloadFile:(NSString*)subPath;


/**
 * 上传文件
 */

- (void)uploadFile:(NSString*)localSubPath;

/**
 * 云端移动文件
 */

- (void)moveFileTo;

/**
 * 云端删除文件
 */

- (void)deleteFile;

/**
 * 云端拷贝
 */

- (void)copyFileTo;

@end

NS_ASSUME_NONNULL_END
