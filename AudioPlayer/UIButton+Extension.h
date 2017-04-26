//
//  UIButton+Extension.h
//  YHHBaiSiProject
//
//  Created by Yang on 17/1/9.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YHHButtonEdgeInsetsStyle) {
    YHHButtonEdgeInsetsStyleTop,     //image在上 label在下
    YHHButtonEdgeInsetsStyleLeft,    //image在左 label在右
    YHHButtonEdgeInsetsStyleBottom,  //image在下 label在上
    YHHButtonEdgeInsetsStyleRight    //image在右 label在左
};
@interface UIButton (Extension)

+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action;

+ (instancetype)buttonWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle image:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action;
/**
 *  设置button imageView与titleLabel的布局样式，及间距
 *  
 *  @param style imageView与titleLabel 的布局样式
 *  @param space imageView与titleLabel 之间的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(YHHButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;
@end
