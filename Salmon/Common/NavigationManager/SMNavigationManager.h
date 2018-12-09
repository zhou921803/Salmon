//
//  SMNavigationManager.h
//  Salmon
//
//  Created by 周正炎 on 2018/12/8.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMNavigationManager : NSObject

SINGLETON_DEC(SMNavigationManager);

@property (nonatomic, weak) UINavigationController *navigationController;


- (void)setupWithNavigationController:(UINavigationController *)navigationController;

@end

NS_ASSUME_NONNULL_END
