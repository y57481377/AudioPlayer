//
//  YHHNavigationController.m
//  AudioPlayer
//
//  Created by Yang on 2017/4/25.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHNavigationController.h"

@interface YHHNavigationController ()

@end

@implementation YHHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航栏 侧滑返回 功能有效
    [self setNavigationBarHidden:NO];
    // 设置隐藏导航栏
    [self.navigationBar setHidden:YES];
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
