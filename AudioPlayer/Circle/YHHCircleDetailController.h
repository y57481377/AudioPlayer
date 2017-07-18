//
//  YHHCircleDetailController.h
//  AudioPlayer
//
//  Created by Yang on 2017/6/8.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHRootViewController.h"

@interface YHHCircleDetailController : YHHRootViewController
@property (strong, nonatomic) NSString *articleId;
@property (strong, nonatomic) void(^commentBlock)();
@end
