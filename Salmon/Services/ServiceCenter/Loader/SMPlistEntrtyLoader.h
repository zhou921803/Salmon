//
//  SMPlistEntrtyLoader.h
//  Salmon
//
//  Created by 周正炎 on 2019/1/15.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISMServiceEntryLoader.h"
NS_ASSUME_NONNULL_BEGIN

@interface SMPlistEntrtyLoader : NSObject<ISMServiceEntryLoader>

@property(nonatomic,strong) NSString* filePath;
@property(nonatomic,assign) BOOL enableMock;

@end

NS_ASSUME_NONNULL_END
