//
//  SMWebDAVItem.m
//  Salmon
//
//  Created by 周正炎 on 2019/3/15.
//  Copyright © 2019 周正炎. All rights reserved.
//

#import "SMWebDAVItem.h"
#import "LEOWebDAVItem.h"


@interface SMWebDAVItem()

@property (nonatomic, strong) LEOWebDAVItem *davItem;

@end


@implementation SMWebDAVItem

- (instancetype)initWithWebDAVItem:(LEOWebDAVItem *)davItem
{
    self = [super init];
    if (self) {
        self.davItem = davItem;
    }
    return self;
}

- (NSString*)toJsonString
{
    NSMutableDictionary *propertys = [[NSMutableDictionary alloc] initWithCapacity:5];
    
    propertys[@"isFile"] = @(self.isFile);
    propertys[@"isDir"] = @(self.isDir);
    propertys[@"displayName"] = self.displayName;
    propertys[@"rootUrl"] = self.rootUrl;
    propertys[@"relativePath"] = self.relativePath;
    propertys[@"absolutePath"] = self.absolutePath;
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:propertys options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = @"";
    
    if(jsonData){
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

#pragma mark - property
- (BOOL)isFile
{
    return LEOWebDAVItemTypeFile == self.davItem.type;
}

- (BOOL)isDir
{
    return LEOWebDAVItemTypeCollection == self.davItem.type;
}

- (NSString *)displayName
{
    return self.davItem.displayName;
}

- (NSString *)rootUrl
{
    return self.davItem.rootURL.absoluteString;
}

- (NSString *)relativePath
{
    return self.davItem.relativeHref;
}

-(NSString *)absolutePath
{
    return [self.davItem.rootURL.absoluteString stringByAppendingString:self.davItem.relativeHref];
}


@end
