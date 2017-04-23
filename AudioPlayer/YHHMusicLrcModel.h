//
//  YHHMusicLrcModel.h
//  AudioPlayer
//
//  Created by Yang on 17/4/21.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHHMusicLrcModel : NSObject
//一句歌词
@property (strong, nonatomic) NSString *text;
// 每句歌词对应的时间
@property (assign, nonatomic) NSTimeInterval time;
@end
