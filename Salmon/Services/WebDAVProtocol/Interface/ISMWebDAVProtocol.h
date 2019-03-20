//
//  ISMWebDAVProtocol.h
//  Salmon
//
//  Created by 周正炎 on 2019/3/8.
//  Copyright © 2019 周正炎. All rights reserved.
//

#ifndef ISMWebDAVProtocol_h
#define ISMWebDAVProtocol_h

#import "SMWebDAVClientCompletion.h"

@protocol ISMWebDAVProtocol <ISMService>

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
- (void)getPathProperty:(NSString*)subPath
             completion:(PropertyCompletion)completion;

/**
 * 下载文件
 */

- (void)downloadFile:(NSString*)subPath
          completion:(DownloadCompeltion)completion;

@end


#endif /* ISMNetSyncProtocol_h */
