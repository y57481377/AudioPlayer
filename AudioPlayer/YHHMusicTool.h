//
//  YHHMusicTool.h
//  AudioPlayer
//
//  Created by Yang on 17/4/21.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHHMusicModel;
@interface YHHMusicTool : NSObject

+ (YHHMusicModel *)previousMusic;

+ (YHHMusicModel *)playingMusic;

+ (YHHMusicModel *)nextMusic;

@end
