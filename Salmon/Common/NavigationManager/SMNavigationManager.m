//
//  SMNavigationManager.m
//  Salmon
//
//  Created by 周正炎 on 2018/12/8.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import "SMNavigationManager.h"

@interface SMNavigationManager()<UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *switchingViewController;
@property (nonatomic, assign) BOOL isNavigationSwitching;

@end

@implementation SMNavigationManager 

SINGLETON_DEF(SMNavigationManager);

#pragma mark - Public

- (void)setupWithNavigationController:(UINavigationController *)navigationController
{
    self.navigationController = navigationController;
    self.navigationController.delegate = self;
}


- (BOOL)pushViewController:(UIViewController *)vc
{
    SMLogInfo(@"{Switch} vc: %@", vc);
    return [self pushViewController:vc animated:YES];
}

- (BOOL)pushViewController:(UIViewController *)vc animated:(BOOL)animated
{
    if (!vc) {
        SMLogWarn(@"{Switch} viewController is nil");
        return NO;
    }
    
    if ([self.navigationController.viewControllers containsObject:vc]) {
        SMLogWarn(@"{Switch} viewController is aleady in navigationController.viewControllers");
        NSAssert(NO, @"pushing the same view controller instance more than once is not supported");
        return NO;
    }
    
    if (animated) {
        if ([self canSwitchViewController]) {
            self.isNavigationSwitching = YES;
            self.switchingViewController = vc;
            SMLogInfo(@"{Switch} pushViewController: %@ animated: %d", vc, animated);
            [self.navigationController pushViewController:vc animated:animated];
            return YES;
        } else {
            SMLogError(@"{Switch} fail to pushViewController: %@ animated: %d, isNavigationSwitching: %d, presentedViewController: %@", vc, self.isNavigationSwitching, animated,  self.navigationController.presentedViewController);
            return NO;
        }
        
    } else {
        SMLogInfo(@"{Switch} pushViewController: %@ animated: %d, isNavigationSwitching: %d:", vc, animated, self.isNavigationSwitching);
        [self.navigationController pushViewController:vc animated:NO];
        return YES;
    }
}

///**
// * 弹出当前 ViewController
// */
//- (BOOL)popViewControllerAnimated:(BOOL)animated
//{
//    SMLogInfo(@"{Switch} animated: %d", animated);
//    return [self popToViewController:[self previousViewController] animated:animated];
//}
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
//
//#pragma mark - UINavigationControllerDelegate
//
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    
//    //[salmon:tag] 这里抛通知是为了什么？
////    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNavigationWillShowViewController object:nil userInfo:@{kUserInfoKeyNavigationViewController: viewController}];
//    
//    //[NOTE] 修改navigationBar底部的线, 过滤隐藏导航条的页面,否则会在顶部出现一条线
//    //if ([self.clearBottomBorderViewControllerList containsObject:NSStringFromClass([viewController class])]) {
//    //    [navigationController.navigationBar clearBottomBorderColor];
//    //}
//    
//    SMLogInfo(@"{Switch} willShowViewController: %@ animated: %d, isNavigationSwitching: %d", viewController, animated, self.isNavigationSwitching);
//}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //[salmon:tag] 这里抛通知是为了什么？
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNavigationDidShowViewController object:nil userInfo:@{kUserInfoKeyNavigationViewController: viewController}];
    
    SMLogInfo(@"{Switch} didShowViewController: %@ animated: %d, isNavigationSwitching: %d, self.switchingViewController: %@", viewController, animated, self.isNavigationSwitching, self.switchingViewController);
    if (self.isNavigationSwitching && self.switchingViewController && viewController != self.switchingViewController) {
        SMLogError(@"{Switch} ignore for viewController != self.switchingViewController");
        return;
    }
    self.switchingViewController = nil;
    self.isNavigationSwitching = NO;
    SMLogInfo(@"{Switch} isNavigationSwitching: 0, self.switchingViewController: nil");
    
    //[salmon:tag] 是否支持返回手势
    BOOL popGestureRecognizerEnabled = [self popGestureRecognizerEnabled:viewController];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = popGestureRecognizerEnabled;
    
    //显示完毕之后判断是否需要Pop，处理pop操作队列。
//    [self fixPopViewControllerIfNeed];
}

//- (void)fixPopViewControllerIfNeed
//{
//    if (self.popVCAnimateQueue.count) {
//        PopVCInfo *info = [self.popVCAnimateQueue firstObject];
//        [self.popVCAnimateQueue removeObjectAtIndex:0];
//
//        //需要放到下一个runloop执行，否则当前显示的viewController viewWillDisappear方法不会调到，导致navigationbar错乱。https://yypm.com:8443/browse/IOSGAMELIVE-10689
//        dispatch_async(dispatch_get_main_queue(), ^{
//            KWSLogInfo(@"{Switch} fix popViewController controller: %@, animate: %d", info.controller, info.animate);
//            if (info.controller) {
//                [[HYNavigationManager sharedObject] popToViewController:info.controller animated:info.animate];
//            } else {
//                [[HYNavigationManager sharedObject] popViewControllerAnimated:info.animate];
//            }
//        });
//    }
//}

#pragma mark - Private

- (BOOL)canSwitchViewController
{
    BOOL canSwitch = !self.isNavigationSwitching && !self.navigationController.presentedViewController;
    if (!canSwitch) {
        SMLogWarn(@"{Switch} canSwitchViewController return NO, isNavigationSwitching: %d, presentedViewController: %@", self.isNavigationSwitching, self.navigationController.presentedViewController);
    }
    return canSwitch;
}


- (BOOL)popGestureRecognizerEnabled:(UIViewController*)viewController {
    BOOL popGestureRecognizerEnabled = YES;
//    if (self.navigationController.viewControllers.count == 1) {
//        popGestureRecognizerEnabled = NO;
//    } else if ([viewController isKindOfClass:NSClassFromString(@"ChannelViewController")]) {
//        //如果是从全屏频道切换过来，禁用手势
//        popGestureRecognizerEnabled = NO;
//    } else if ([viewController   isKindOfClass:NSClassFromString(@"SearchViewController")]) {
//        //录播页和手机直播页禁用滑动返回手势
//        popGestureRecognizerEnabled = NO;
//    } else if ([viewController   isKindOfClass:NSClassFromString(@"RecordedVideoPlayViewController")] || [viewController   isKindOfClass:NSClassFromString(@"HYVideoViewController")]) {
//
//        UIViewController *lastViewController = [self.navigationController.viewControllers safeObjectAtIndex:self.navigationController.viewControllers.count - 2];
//        if ([lastViewController isKindOfClass:NSClassFromString(@"ImmersionPlayListViewController")]){
//            popGestureRecognizerEnabled = NO;
//        }
//    }
    return popGestureRecognizerEnabled;
}



@end
