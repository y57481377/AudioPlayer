//
//  YHHMusicTool.m
//  AudioPlayer
//
//  Created by Yang on 17/4/21.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHMusicTool.h"
#import "YHHMusicModel.h"

@implementation YHHMusicTool

static NSArray *_musicModels;
static YHHMusicModel *_music;

+ (void)initialize {
    [super initialize];
    if (!_musicModels) {
        _musicModels = [YHHMusicModel getMusics];
    }
    if (!_music) {
        _music = _musicModels[0];
    }
}

+ (YHHMusicModel *)previousMusic {
    NSInteger count = _musicModels.count;
    NSInteger index = [_musicModels indexOfObject:_music];
    if (index == 0) {
        _music = _musicModels[count - 1];
    }else {
        _music = _musicModels[index - 1];
    }
    return _music;
}

+ (YHHMusicModel *)playingMusic {
    return _music;
}

+ (YHHMusicModel *)nextMusic {
    NSInteger count = _musicModels.count;
    NSInteger index = [_musicModels indexOfObject:_music];
    if (index == count - 1) {
        _music = _musicModels[0];
    }else {
        _music = _musicModels[index + 1];
    }
    return _music;
}

@end
