//
//  SMWebDAVClient.m
//  Salmon
//
//  Created by 周正炎 on 2019/3/9.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import "SMWebDAVClient.h"

#import "LEOWebDAVClient.h"

#import "LEOWebDAVCopyRequest.h"
#import "LEOWebDAVDeleteRequest.h"
#import "LEOWebDAVDownloadRequest.h"
#import "LEOWebDAVMakeCollectionRequest.h"
#import "LEOWebDAVMoveRequest.h"
#import "LEOWebDAVPropertyRequest.h"
#import "LEOWebDAVUploadRequest.h"
#import "SMWebDAVItem.h"


@interface SMWebDAVClient()

@property (nonatomic, strong) LEOWebDAVClient *davClient;
@property (nonatomic, copy) NSString *localMappingPath;
@end



@implementation SMWebDAVClient

SINGLETON_DEF(SMWebDAVClient)

/**
 * 配置WebDAV客户端，网络url映射到本地的路径
 */
- (BOOL)configClientWith:(NSString*)rootUrl
                userName:(NSString*)userName
                passWord:(NSString*)passWord
        localMappingPath:(NSString*)localMappingPath
{
    BOOL bRet = NO;
    self.localMappingPath = localMappingPath;
    
    self.davClient = [[LEOWebDAVClient alloc] initWithRootURL:[NSURL URLWithString:rootUrl] andUserName:userName andPassword:passWord];
    if(self.davClient){
        bRet = YES;
    }
    
    return bRet;
}

/**
 * 文件路径属性获取
 */

- (void)getPathProperty:(NSString*)subPath
             completion:(PropertyCompletion)completion
{
    LEOWebDAVPropertyRequest *request=[[LEOWebDAVPropertyRequest alloc] initWithPath:subPath];
    request.requestCompletion = ^(NSError *error, id result, LEOWebDAVRequest *request) {
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
        
        if([result isKindOfClass:[NSArray class]]){
            NSArray *resultArray = result;
            for(NSInteger index = 0; index < resultArray.count; ++index){
                LEOWebDAVItem *davItem = resultArray[index];
                SMWebDAVItem *smDavItem = [[SMWebDAVItem alloc] initWithWebDAVItem:davItem];
                [items addObject:smDavItem];
            }
        }
        
        if(completion){
            completion(error, [items copy]);
        }
    }; 
    [self.davClient enqueueRequest:request];
}

/**
 * 下载文件
 */

- (void)downloadFile:(NSString*)subPath
          completion:(DownloadCompeltion)completion
{
    LEOWebDAVDownloadRequest *request = [[LEOWebDAVDownloadRequest alloc] initWithPath:subPath];
    __weak typeof(self) weakSelf = self;
    request.requestCompletion = ^(NSError *error, id result, LEOWebDAVRequest *request) {
        
        if (result && [result isKindOfClass:[NSData class]]) {
            // 创建文件首先需要一个文件管理对象
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            NSString *filePath = [weakSelf.localMappingPath stringByAppendingPathComponent:request.path];
            NSString *filePathDir = [filePath stringByDeletingLastPathComponent];
            
            [fileManager createDirectoryAtPath:filePathDir withIntermediateDirectories:YES attributes:nil error:nil];
            
            NSData *data = result;
            [fileManager createFileAtPath:filePath contents:data attributes:nil];
            
            if(completion){
                completion(nil, filePath);
            }
            
        } else {
            completion(error, nil);
        }
    };
    [self.davClient enqueueRequest:request];
}

//- (void)downloadFile:(NSString*)subPath
//{
//    LEOWebDAVDownloadRequest *request = [[LEOWebDAVDownloadRequest alloc] initWithPath:subPath];
////    request.delegate = self;
//    [self.davClient enqueueRequest:request];
//}

#pragma mark - LEOWebDAVRequestDelegate

//- (void)request:(LEOWebDAVRequest *)request didFailWithError:(NSError *)error
//{
//    NSLog(@"error:%@",[error description]);
//}
//- (void)request:(LEOWebDAVRequest *)request didSucceedWithResult:(id)result
//{
//    if ([request isKindOfClass:[LEOWebDAVPropertyRequest class]]) {    //属性获取
//        NSLog(@"success:%@",result);
//
//    }else if ([request isKindOfClass:[LEOWebDAVDownloadRequest class]]){   //下载
//        if (result && [result isKindOfClass:[NSData class]]) {
//            // 创建文件首先需要一个文件管理对象
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//
//            NSString *filePath = [self.localMappingPath stringByAppendingPathComponent:request.path];
//            NSString *filePathDir = [filePath stringByDeletingLastPathComponent];
//
//            [fileManager createDirectoryAtPath:filePathDir withIntermediateDirectories:YES attributes:nil error:nil];
//
//            NSData *data = result;
////            [data writeToFile:filePath atomically:YES];
//            [fileManager createFileAtPath:filePath contents:data attributes:nil];
//        }
//    }
//}

@end
