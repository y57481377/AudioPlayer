//
//  UIButton+Extension.m
//  YHHBaiSiProject
//
//  Created by Yang on 17/1/9.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    [btn sizeToFit];
    return btn;
}

+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action {
    
    UIButton *btn = [self buttonWithTitle:title target:target action:action];
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    [btn sizeToFit];
    return btn;
}

+ (instancetype)buttonWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle image:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action {
    
    UIButton *btn = [self buttonWithTitle:title image:image target:target action:action];
    
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
//    [btn sizeToFit];
    return btn;
}

- (void)layoutButtonWithEdgeInsetsStyle:(YHHButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space {
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    CGFloat imageWidth = self.imageView.bounds.size.width;
    CGFloat imageHeight = self.imageView.bounds.size.height;
    
    CGFloat labelWidth = self.titleLabel.bounds.size.width;
    CGFloat labelHeight = self.titleLabel.bounds.size.height;
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    switch (style) {
        case YHHButtonEdgeInsetsStyleTop:     // 图上 文下
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space, labelWidth, 0, 0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space, 0);
            break;
        case YHHButtonEdgeInsetsStyleLeft:    // 图左 文右(与系统默认相同)
            imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2, 0, 0);
            labelEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -space / 2);
            break;
        case YHHButtonEdgeInsetsStyleBottom:  // 图下 文上
            imageEdgeInsets = UIEdgeInsetsMake(labelHeight+space, labelWidth, 0, 0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, imageHeight+space, 0);
            break;
        case YHHButtonEdgeInsetsStyleRight:   // 图右 文左
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space / 2, 0, -labelWidth - space / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - space / 2, 0, imageWidth + space / 2.0);
            break;
        default:
            break;
    }
    
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = labelEdgeInsets;
}


@end
