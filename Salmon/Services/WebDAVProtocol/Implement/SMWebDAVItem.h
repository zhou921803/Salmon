//
//  SMWebDAVItem.h
//  Salmon
//
//  Created by 周正炎 on 2019/3/15.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISMWebDAVItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMWebDAVItem : NSObject<ISMWebDAVItem>

@property (nonatomic, assign, readonly) BOOL isFile;
@property (nonatomic, assign, readonly) BOOL isDir;
@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSString *rootUrl;
@property (nonatomic, copy, readonly) NSString *relativePath;
@property (nonatomic, copy, readonly) NSString *absolutePath;

@end

NS_ASSUME_NONNULL_END
