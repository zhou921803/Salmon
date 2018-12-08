//
//  SMCommomMacros.h
//  Salmon
//
//  Created by 周正炎 on 2018/11/30.
//  Copyright © 2018 周正炎. All rights reserved.
//

#ifndef SMCommomMacros_h
#define SMCommomMacros_h

#ifdef DEBUG
#define HYINTERNAL
#endif

/*********************************************************************/
//单例声明
#define SINGLETON_DEC(class_name) + (instancetype)sharedObject;

//单例定义
#define SINGLETON_DEF(class_name) + (instancetype)sharedObject\
{\
static class_name *sharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
sharedInstance = [[class_name alloc] init];\
});\
return sharedInstance;\
}

//单例实例
#define SINGLETON_OBJECT(class_name)    [class_name sharedObject]


#endif /* SMCommomMacros_h */
