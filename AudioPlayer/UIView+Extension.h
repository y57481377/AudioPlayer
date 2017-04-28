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

- (CGFloat)yhh_Width;
- (CGFloat)yhh_Height;
- (CGFloat)yhh_Y;
- (CGFloat)yhh_X;

- (void)setYhh_Width:(CGFloat)width;
- (void)setYhh_Height:(CGFloat)height;
- (void)setYhh_X:(CGFloat)x;
- (void)setYhh_Y:(CGFloat)y;
@end
