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
static AVPlayer *_player;

+ (void)initialize {
    [super initialize];
    if (!_musicModels) {
        _musicModels = [YHHMusicModel getMusics];
    }
    if (!_music) {
        _music = _musicModels[0];
    }
}

+ (AVPlayer *)audioPlayerWithMusic:(YHHMusicModel *)music {
    // 获取音乐文件路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:music.fileName withExtension:nil];
    NSLog(@"%@",url);
    
    // 如果当前音乐已经在播放，则不创建播放器Item
    if (_player && [[self playingMusic].fileName isEqualToString:music.fileName]) return _player;
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    
    _player = [AVPlayer playerWithPlayerItem:playerItem];
    
    return _player;
}

+ (AVPlayer *)playNextMusic {
    YHHMusicModel *music = [self nextMusic];
    NSURL *url = [[NSBundle mainBundle] URLForResource:music.fileName withExtension:nil];
    NSLog(@"%@",url);
//    NSError *error = nil;
    
    // 如果已经有在播放的音乐，则不创建播放器
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];

    [_player replaceCurrentItemWithPlayerItem:playerItem];
    
    return _player;
}

+ (AVPlayer *)playPreviousMusic {
    YHHMusicModel *music = [self previousMusic];
    NSURL *url = [[NSBundle mainBundle] URLForResource:music.fileName withExtension:nil];
    NSLog(@"%@",url);
//    NSError *error = nil;
    
    // 如果已经有在播放的音乐，则不创建播放器
    if (_player)  [_player pause];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    
    [_player replaceCurrentItemWithPlayerItem:playerItem];
    
    return _player;
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
