//
//  YHHRootViewController.m
//  AudioPlayer
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 YHH. All rights reserved.
//  拥有导航栏的控制器继承该控制器，拥有自定义的导航栏

#import "YHHRootViewController.h"
#import "YHHNavigationBar.h"

@interface YHHRootViewController ()
@property (strong, nonatomic) YHHNavigationBar *navBar;
@end

@implementation YHHRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navBar = [[YHHNavigationBar alloc] init];
    _navBar.backgroundColor = red_Globe_Color;
    
    [self setBackItem];
    [self.view addSubview:_navBar];
}

- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
}

// 设置返回按钮
- (void)setBackItem {
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *leftBack = [UIButton buttonWithTitle:nil image:@"back" target:self action:@selector(popController)];
        _navBar.backItem = leftBack;
    }
}

#pragma mark --- 公开方法
- (void)setNavBarColor:(UIColor *)color {
    _navBar.backgroundColor = color;
}

- (void)setNavBarShadowColor:(UIColor *)color {
    [_navBar setShadowColor:color];
}

- (void)setNavBarTitleView:(UIView *)view {
    _navBar.titleView = view;
}

- (void)setNavBarTitle:(NSString *)title {
    [_navBar setTitle:title];
}

- (void)setNavBarLeftItem:(UIButton *)btn {
    _navBar.leftItem = btn;
}

- (void)setNavBarLeftItems:(NSArray<UIButton *> *)items {
    _navBar.leftItems = items;
}

- (void)setNavBarRightItem:(UIButton *)btn {
    _navBar.rightItem = btn;
}

- (void)setNavBarRightItems:(NSArray<UIButton *> *)items {
    _navBar.rightItems = items;
}

@end
