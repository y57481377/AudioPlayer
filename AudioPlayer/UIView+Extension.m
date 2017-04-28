//
//  UIView+Extension.m
//  AudioPlayer
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setSeparatorWithColor:(UIColor *)color {
    if (!color) {
        color = white_Text_Color;
    }
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
    separator.backgroundColor = color;
    [self addSubview: separator];
}

- (CGFloat)yhh_Width {
    return self.frame.size.width;
}
- (CGFloat)yhh_Height {
    return self.frame.size.height;
}
- (CGFloat)yhh_X {
    return self.frame.origin.x;
}
- (CGFloat)yhh_Y {
    return self.frame.origin.y;
}

- (void)setYhh_Width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setYhh_Height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setYhh_X:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setYhh_Y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
@end
