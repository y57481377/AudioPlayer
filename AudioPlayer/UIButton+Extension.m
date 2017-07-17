//
//  UIButton+Extension.m
//  YHHBaiSiProject
//
//  Created by Yang on 17/1/9.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

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


@implementation UIButton (Set)
static void(^actionBlock)(UIButton *btn);
- (setBlock)yhh_title {
    __weak typeof(self) weakSelf = self;
    return ^UIButton *(NSString *str, UIControlState state) {
        [weakSelf setTitle:str forState:state];
        return weakSelf;
    };
}

- (setBlock)yhh_image {
    __weak typeof(self) weakSelf = self;
    return ^UIButton *(id image, UIControlState state) {
        if ([image isKindOfClass:[NSString class]]) {
            image = [UIImage imageNamed:image];
        }
        [weakSelf setImage:image forState:state];
        return weakSelf;
    };
}

- (setBlock)yhh_backgroundImage {
    __weak typeof(self) weakSelf = self;
    return ^UIButton *(id image, UIControlState state) {
        if ([image isKindOfClass:[NSString class]]) {
            image = [UIImage imageNamed:image];
        }
        [weakSelf setBackgroundImage:image forState:state];
        return weakSelf;
    };
}

+ (instancetype)yhh_buttonWithSetProperty:(void(^)(UIButton *btn))setProperty action:(void(^)(UIButton *btn))action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(setProperty) setProperty(btn);
    
    actionBlock = action;
    [btn addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (void)touchAction:(UIButton *)btn {
    if (actionBlock) {
        actionBlock(btn);
    }
}
@end
