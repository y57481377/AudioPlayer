//
//  UIImage+Extention.m
//  AudioPlayer
//
//  Created by YANG on 17/4/22.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

+ (UIImage *)yhh_imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 0.5);
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
