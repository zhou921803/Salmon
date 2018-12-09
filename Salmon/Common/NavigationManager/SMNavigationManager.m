//
//  SMNavigationManager.m
//  Salmon
//
//  Created by 周正炎 on 2018/12/8.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import "SMNavigationManager.h"

@interface SMNavigationManager()<UINavigationControllerDelegate>



@end

@implementation SMNavigationManager 

SINGLETON_DEF(SMNavigationManager);

#pragma mark - Public

- (void)setupWithNavigationController:(UINavigationController *)navigationController
{
    self.navigationController = navigationController;
    self.navigationController.delegate = self;
}

@end
