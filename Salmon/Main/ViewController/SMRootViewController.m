//
//  SMRootViewController.m
//  Salmon
//
//  Created by 周正炎 on 2018/11/30.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import "SMRootViewController.h"

@interface SMRootViewController ()

@end

@implementation SMRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return [super forwardingTargetForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL sel = anInvocation.selector;
    [self doesNotRecognizeSelector:sel];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
