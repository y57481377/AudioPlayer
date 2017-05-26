//
//  UIView+Extension.h
//  AudioPlayer
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
//根据颜色设置分割线
- (void)setSeparatorWithColor:(UIColor *)color;

//设置圆角
- (void)setCornerRadius:(CGFloat)radius;
//设置view为圆形
- (void)circle;
//@property (assign, nonatomic) CGFloat borderWidth;
//@property (strong, nonatomic) UIColor *borderColor;

- (CGFloat)yhh_Width;
- (CGFloat)yhh_Height;
- (CGFloat)yhh_Y;
- (CGFloat)yhh_X;
- (CGFloat)yhh_MaxX;
- (CGFloat)yhh_MaxY;

- (void)setYhh_Width:(CGFloat)width;
- (void)setYhh_Height:(CGFloat)height;
- (void)setYhh_X:(CGFloat)x;
- (void)setYhh_Y:(CGFloat)y;

@end
