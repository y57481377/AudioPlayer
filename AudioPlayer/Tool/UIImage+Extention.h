//
//  UIImage+Extention.h
//  AudioPlayer
//
//  Created by YANG on 17/4/22.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)

- (UIImage *)circleImage;

- (void)circleImageCompleted:(void(^)(UIImage *circleImage))completed;

+ (UIImage *)yhh_imageWithColor:(UIColor *)color;

@end
