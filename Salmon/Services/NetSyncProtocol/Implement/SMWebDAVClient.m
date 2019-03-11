//
//  SMWebDAVClient.m
//  Salmon
//
//  Created by 周正炎 on 2019/3/9.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import "SMWebDAVClient.h"

#import "LEOWebDAVClient.h"
#import "LEOWebDAVRequest.h"

#import "LEOWebDAVCopyRequest.h"
#import "LEOWebDAVDeleteRequest.h"
#import "LEOWebDAVDownloadRequest.h"
#import "LEOWebDAVMakeCollectionRequest.h"
#import "LEOWebDAVMoveRequest.h"
#import "LEOWebDAVPropertyRequest.h"
#import "LEOWebDAVUploadRequest.h"


@interface SMWebDAVClient()<LEOWebDAVRequestDelegate>

@end

@implementation SMWebDAVClient




#pragma mark - LEOWebDAVRequestDelegate

- (void)request:(LEOWebDAVRequest *)request didFailWithError:(NSError *)error
{
    
}
- (void)request:(LEOWebDAVRequest *)request didSucceedWithResult:(id)result
{
    
}

@end
