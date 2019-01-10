//
//  ISMService.h
//  Salmon
//
//  Created by 周正炎 on 2018/12/10.
//  Copyright © 2018 周正炎. All rights reserved.
//

#ifndef ISMService_h
#define ISMService_h


/**
 * 服务协议
 */
@protocol ISMService <NSObject>

@optional

// 有了servicemanager之后呢按道理来说是由manager来实现单例的
// 这样做是为了过渡兼容老代码，同时这样做也避免了线程安全问题
+ (instancetype)sharedObject;

+ (instancetype)sharedInstance;

- (BOOL)singleton;

@end


#endif /* ISMService_h */
