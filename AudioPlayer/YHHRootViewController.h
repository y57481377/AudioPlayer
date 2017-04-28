//
//  YHHRootViewController.h
//  AudioPlayer
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 YHH. All rights reserved.
//  拥有导航栏的控制器继承该控制器，拥有自定义的导航栏

#import <UIKit/UIKit.h>
#import "YHHNavigationBar.h"
@interface YHHRootViewController : UIViewController

@property (strong, nonatomic) YHHNavigationBar *navBar;

/*** 设置自定义导航栏的属性 ***/
- (void)setNavBarColor:(UIColor *)color;         /*设置导航条颜色*/
- (void)setNavBarShadowColor:(UIColor *)color;   /*设置导航条分割线颜色*/

- (void)setNavBarTitle:(NSString *)title;        /*设置导航条 标题*/
- (void)setNavBarTitleView:(UIView *)view;       /*设置导航条TitleView*/

// 设置导航栏 左/右按钮
- (void)setNavBarLeftItem:(UIButton *)btn;
- (void)setNavBarLeftItems:(NSArray<UIButton *> *)items;

- (void)setNavBarRightItem:(UIButton *)btn;
- (void)setNavBarRightItems:(NSArray<UIButton *> *)items;
@end
