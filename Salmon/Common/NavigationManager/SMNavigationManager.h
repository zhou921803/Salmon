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
@property (nonatomic, assign, readonly) BOOL isNavigationSwitching;


- (void)setupWithNavigationController:(UINavigationController *)navigationController;

/**
 * 收敛 navigationController 的 push 入口，切换动画默认为 YES
 * @param vc 将要切换到的 UIViewController
 * @return 成功切换返回 YES，否则返回 NO
 */
- (BOOL)pushViewController:(UIViewController *)vc;

- (BOOL)pushViewController:(UIViewController *)vc animated:(BOOL)animated;

///**
// * 弹出当前 ViewController
// */
//- (BOOL)popViewControllerAnimated:(BOOL)animated;
//
///**
// * 弹出到某个 ViewController
// */
//- (BOOL)popToViewController:(UIViewController *)vc animated:(BOOL)animated;
//
///**
// * 弹出到 RootViewController
// */
//- (BOOL)popToRootViewControllerAnimated:(BOOL)animated;
//
///**
// * 顺序弹出n个顶部的 ViewController
// */
//- (BOOL)popTopViewControllers:(NSInteger)popCount animated:(BOOL)animated;
//
//
///**
// * 把viewController从navigation栈中移除
// */
//- (BOOL)removeViewController:(UIViewController *)vc;
//
///**
// * 把 目标VC 直接加到 ParentVC 上面
// */
//- (BOOL)embedViewController:(UIViewController *)vc inParentViewController:(UIViewController *)parentVC animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
