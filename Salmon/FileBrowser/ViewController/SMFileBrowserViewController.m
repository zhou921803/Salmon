//
//  SMFileBrowserViewController.m
//  Salmon
//
//  Created by 周正炎 on 2018/12/8.
//  Copyright © 2018 周正炎. All rights reserved.
//

#import "SMFileBrowserViewController.h"

@interface SMFileBrowserViewController ()

@property (nonatomic, strong) UIButton *testButton;

@end

@implementation SMFileBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.testButton];

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
