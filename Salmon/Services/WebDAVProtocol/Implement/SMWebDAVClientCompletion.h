//
//  SMWebDAVClientCompletion.h
//  Salmon
//
//  Created by 周正炎 on 2019/3/15.
//  Copyright © 2019 周正炎. All rights reserved.
//

#ifndef SMWebDAVClientCompletion_h
#define SMWebDAVClientCompletion_h

#import "ISMWebDAVItem.h"

typedef void (^PropertyCompletion)(NSError *error, NSArray<ISMWebDAVItem> *items);

typedef void (^DownloadCompeltion)(NSError *error, NSString *downloadedPath);

#endif /* SMWebDAVClientCompletion_h */
