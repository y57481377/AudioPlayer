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
    
        CGFloat len = MIN(self.size.width, self.size.height);
        CGRect rect = CGRectMake(0, 0, len, len);
        /* 从矩形图片中心点截取最大正方形   */
        CGImageRef imageRef = self.CGImage;
        CGImageRef squareRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, (self.size.height - len) *0.5, len, len));
        UIImage *newImage = [UIImage imageWithCGImage:squareRef];
        CGImageRelease(squareRef);
        
        /* 从截取出来的正方形图片里边裁剪成圆形图片 */
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, len*0.5, 0, M_PI * 2, 0);
        CGContextClip(context);
        [newImage drawInRect:rect];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
        return image;
}


- (void)circleImageCompleted:(void(^)(UIImage *circleImage))completed{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGFloat len = MIN(self.size.width, self.size.height);
        CGRect rect = CGRectMake(0, 0, len, len);
        /* 从矩形图片中心点截取最大正方形   */
        CGImageRef imageRef = self.CGImage;
        CGImageRef squareRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, (self.size.height - len) *0.5, len, len));
        UIImage *newImage = [UIImage imageWithCGImage:squareRef];
        CGImageRelease(squareRef);
        
        /* 从截取出来的正方形图片里边裁剪成圆形图片 */
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, len*0.5, 0, M_PI * 2, 0);
        CGContextClip(context);
        [newImage drawInRect:rect];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
//        NSLog(@"%@---square%@---%f-----after:%@", NSStringFromCGSize(rect.size), NSStringFromCGSize(newImage.size), len, NSStringFromCGSize(image.size));
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completed(image);
        });
    });
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
