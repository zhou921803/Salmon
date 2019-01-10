//
//  SMServiceTypes.m
//  Salmon
//
//  Created by 周正炎 on 2018/12/10.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import "SMServiceTypes.h"

@interface SMServiceEntry()

@property(nonatomic,strong) Class cls;
@property(nonatomic,strong) Protocol* protocol;

@end

@implementation SMServiceEntry

- (id)initWithClass:(Class)theClass
           protocol:(Protocol *)protocol
               type:(SMServiceEntryType)type
{
    if (self = [super init]) {
        _cls = theClass;
        _protocol = protocol;
        _type = type;
    }
    return self;
}

@end



@implementation SMServiceEntryConfig

@end
