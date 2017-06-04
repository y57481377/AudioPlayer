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

- (void)setCornerRadius:(CGFloat)radius {
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
//    
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.path = path.CGPath;
//    
//    self.layer.mask = maskLayer;
}

- (void)circle {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (![self isKindOfClass:[UIImageView class]]) return;
        
        UIImageView *imagev = (UIImageView *)self;
        CGFloat len = MIN(self.yhh_Width, self.yhh_Height) / 2;
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextAddArc(context, self.yhh_Width / 2, self.yhh_Height / 2, len, 0, M_PI * 2, 0);
        CGContextClip(context);
        [imagev.image drawInRect:self.bounds];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // 获得主线程吧处理后的图片赋值
        dispatch_async(dispatch_get_main_queue(), ^{
            imagev.image = image;
        });
    });
    
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

- (CGFloat)yhh_MaxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)yhh_MaxY {
    return CGRectGetMaxY(self.frame);
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
