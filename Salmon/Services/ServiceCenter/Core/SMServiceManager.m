//
//  SMServiceManager.m
//  Salmon
//
//  Created by 周正炎 on 2018/12/10.
//  Copyright © 2018 周正炎. All rights reserved.
//
#import <pthread.h>
#import "SMServiceManager.h"

@interface SMServiceManager() {
    pthread_mutex_t _lock;
}

@property(nonatomic,strong) NSMutableDictionary* serviceContextDict;        //存储服务协议和类
@property(nonatomic,strong) NSMutableDictionary* serviceDict;               //存储服务协议和对象

@end

@implementation SMServiceManager

- (instancetype)init
{
    if (self = [super init]) {
        _serviceContextDict = [NSMutableDictionary dictionaryWithCapacity:10];
        _serviceDict = [NSMutableDictionary dictionaryWithCapacity:5];
        
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_init(&_lock, &attr);
        pthread_mutexattr_destroy(&attr);
    }
    return self;
}

- (void)dealloc
{
    pthread_mutex_destroy(&_lock);
}

#pragma mark - public

- (BOOL)registerService:(Class)cls toProtocol:(Protocol *)protocol
{
    NSAssert(cls != nil, @"should not be nil");
    NSAssert(protocol != NULL, @"should not be null");
    
    if (cls && protocol != NULL) {
        NSString* protocolStr = NSStringFromProtocol(protocol);
        
        if (!protocolStr) {
            return NO;
        }
        
        if (![cls conformsToProtocol:@protocol(ISMService)]) {
            SMLogError(@"%@ not conformsToProtocol ISMService", cls);
            NSAssert(NO, @"should conformsToProtocol ISMService");
            return NO;
        }
        
        pthread_mutex_lock(&_lock);
        _serviceContextDict[protocolStr] = cls;     //存储类信息
        pthread_mutex_unlock(&_lock);
        return YES;
    }
    return NO;
}

- (BOOL)unregisterService:(Protocol *)protocol
{
    if (protocol != NULL) {
        
        NSString* protocolStr = NSStringFromProtocol(protocol);
        
        if (!protocolStr) {
            return NO;
        }
        
        pthread_mutex_lock(&_lock);
        //把注册相关信息清掉
        [_serviceContextDict removeObjectForKey:protocolStr];
        
        //实例对象也清除
        [_serviceDict removeObjectForKey:protocolStr];
        
        pthread_mutex_unlock(&_lock);
    }
    
    return NO;
}

- (id<ISMService>)serviceWithProtocol:(Protocol *)protocol
{
    NSString* protocolStr = NSStringFromProtocol(protocol);
    
    if (!protocolStr){
        return nil;
    }
    
    pthread_mutex_lock(&_lock);
    id<ISMService> service = [self.serviceDict objectForKey:protocolStr];
    pthread_mutex_unlock(&_lock);
    
    //如果service不存在那么就去创建然后调用start
    if (!service) {
        
        Class cls = [self classWithProtocol:protocol];
        
        if (!cls) {
            NSAssert(NO, @"missing class %@", NSStringFromProtocol(protocol));
            SMLogError(@"missing class %@", NSStringFromProtocol(protocol));
            return nil;
        }
        
        BOOL shareSingleton = NO;
        
        SEL shareSel = @selector(sharedObject);
        
        if (![cls respondsToSelector:shareSel]) {
            
            shareSel = @selector(sharedInstance);
            
            if ([cls respondsToSelector:shareSel]) {
                shareSingleton = YES;
            }
        } else {
            shareSingleton = YES;
        }
        
        if (shareSingleton) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            service = [cls performSelector:shareSel];
#pragma clang diagnostic pop
        } else {
            pthread_mutex_lock(&_lock);
            service = [[cls alloc] init];
            pthread_mutex_unlock(&_lock);
        }
        
        if (service) {
            
            //如果创建出来的实例不支持对应的接口，那么强制报错出来
            if (![service conformsToProtocol:protocol]) {
                NSAssert(NO , @"service not conformsToProtocol: %@", protocol);
                SMLogError(@"service not conformsToProtocol: %@", protocol);
                return nil;
            }
            
            BOOL singleton = shareSingleton;
            
            if (!singleton) {
                
                //如果没实现sharedInstance，那么看其是否实现了singleton
                if([service respondsToSelector:@selector(singleton)]) {
                    singleton = [service singleton];
                }
                
            } else {
                //如果没有实现sharedInstance并且没实现singleton的话默认单例
                //只有在不实现sharedInstance且实现了singleton并返回NO才是新对象
                singleton = YES;
            }
            
            //如果是单例才存起来，否则直接返回
            if (singleton) {
                pthread_mutex_lock(&_lock);
                self.serviceDict[protocolStr] = service;
                pthread_mutex_unlock(&_lock);
            }
        }
    }
    
    return service;
}

#pragma mark - private

- (Class)classWithProtocol:(Protocol *)protocol
{
    if (protocol != NULL) {
        
        NSString* protocolStr = NSStringFromProtocol(protocol);
        
        if (!protocolStr) {
            return nil;
        }
        
        pthread_mutex_lock(&_lock);
        Class cls = self.serviceContextDict[protocolStr];
        pthread_mutex_unlock(&_lock);
        return cls;
    }
    
    return nil;
}

- (id)objectForKeyedSubscript:(Protocol*)key
{
    return [self serviceWithProtocol:key];
}

@end
