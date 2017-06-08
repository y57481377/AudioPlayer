//
//  YHHMusicTool.h
//  AudioPlayer
//
//  Created by Yang on 17/4/21.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class YHHMusicModel;
@interface YHHMusicTool : NSObject
+ (YHHMusicModel *)playingMusic;

+ (AVPlayer *)audioPlayerWithMusic:(YHHMusicModel *)music;

+ (AVPlayer *)playPreviousMusic;

+ (AVPlayer *)playNextMusic;

@end
