//
//  SMWebDAVClient.h
//  Salmon
//
//  Created by 周正炎 on 2019/3/9.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEOWebDAVRequest.h"
#import "SMWebDAVClientCompletion.h"
#import "ISMWebDAVProtocol.h"
NS_ASSUME_NONNULL_BEGIN


@interface SMWebDAVClient : NSObject<ISMWebDAVProtocol>

SINGLETON_DEC(SMWebDAVClient)

/**
 * 配置WebDAV客户端，网络url映射到本地的路径
 */
- (BOOL)configClientWith:(NSString*)rootUrl
                userName:(NSString*)userName
                passWord:(NSString*)passWord
        localMappingPath:(NSString*)localMappingPath;

/**
 * 文件路径属性获取
 */
//- (void)getPathProperty:(NSString*)subPath;
- (void)getPathProperty:(NSString*)subPath
          completion:(PropertyCompletion)completion;

/**
 * 下载文件
 */

- (void)downloadFile:(NSString*)subPath
          completion:(DownloadCompeltion)completion;


///**
// * 上传文件
// */
//
//- (void)uploadFile:(NSString*)localSubPath;
//
///**
// * 云端移动文件
// */
//
//- (void)moveFileTo;
//
///**
// * 云端删除文件
// */
//
//- (void)deleteFile;
//
///**
// * 云端拷贝
// */
//
//- (void)copyFileTo;

@end

NS_ASSUME_NONNULL_END
