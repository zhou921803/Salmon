//
//  ISMWebDAVItem.h
//  Salmon
//
//  Created by 周正炎 on 2019/3/15.
//  Copyright © 2019 周正炎. All rights reserved.
//



#ifndef ISMWebDAVItem_h
#define ISMWebDAVItem_h

@class LEOWebDAVItem;

@protocol ISMWebDAVItem <NSObject>

@property (nonatomic, assign, readonly) BOOL isFile;
@property (nonatomic, assign, readonly) BOOL isDir;
@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSString *rootUrl;
@property (nonatomic, copy, readonly) NSString *relativePath;
@property (nonatomic, copy, readonly) NSString *absolutePath;

- (instancetype)initWithWebDAVItem:(LEOWebDAVItem *)davItem;

/*
 * 转换为json，用于传递到RN
 */
- (NSString*)toJsonString;

@end
#endif /* ISMWebDAVItem_h */
