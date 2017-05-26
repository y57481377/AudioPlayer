//
//  UIImage+Extention.m
//  AudioPlayer
//
//  Created by YANG on 17/4/22.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

- (UIImage *)circleImage {
    CGFloat len = MIN(self.size.width, self.size.height) / 2;
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, len, 0, M_PI * 2, 0);
//    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)yhh_imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开始图形上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}
@end
