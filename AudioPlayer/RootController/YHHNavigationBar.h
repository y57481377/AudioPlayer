//
//  YHHNavigationBar.h
//  AudioPlayer
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHHNavigationBar : UIView
// 导航栏按钮
@property (strong, nonatomic) UIButton *backItem; //返回
@property (strong, nonatomic) UIButton *leftItem;
@property (strong, nonatomic) UIButton *rightItem;

@property (strong, nonatomic) NSArray *leftItems; //设置多个导航栏按键
@property (strong, nonatomic) NSArray *rightItems;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *titleView;
// 标题
- (void)setTitle:(NSString *)title;
// 分割线颜色
- (void)setShadowColor:(UIColor *)color;

@end
