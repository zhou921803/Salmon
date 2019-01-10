//
//  SMMyfilesViewController.m
//  Salmon
//
//  Created by 周正炎 on 2018/12/14.
//  Copyright © 2018 周正炎. All rights reserved.
//
#import <SVProgressHUD/SVProgressHUD.h>
#import "SMMyfilesViewController.h"
#import "SMFileBrowserViewController.h"
#import "SMNavigationManager.h"

@interface SMMyfilesViewController ()
@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, assign) CGFloat progress;
@end

@implementation SMMyfilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self.view addSubview:self.testButton];
    self.progress = 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - action

- (void)onTestButtonClicked:(id)sender
{
    SMLogInfo(@"clicked testButton");
//    SMFileBrowserViewController *fileBrowserViewController = [[SMFileBrowserViewController alloc] init];
//    [SINGLETON_OBJECT(SMNavigationManager) pushViewController:fileBrowserViewController];
    
//    [SVProgressHUD showProgress:self.progress];
//    self.progress += 0.1;
//    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"hello %f", self.progress]];
}

#pragma mark - getter
- (UIButton*)testButton
{
    if(nil == _testButton)
    {
        _testButton = [[UIButton alloc] init];
        _testButton.frame = CGRectMake(100, 100, 100, 50);
        _testButton.backgroundColor = [UIColor redColor];
        [_testButton addTarget:self action:@selector(onTestButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testButton;
}

@end
