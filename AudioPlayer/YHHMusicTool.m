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
static AVAudioPlayer *_player;

+ (void)initialize {
    [super initialize];
    if (!_musicModels) {
        _musicModels = [YHHMusicModel getMusics];
    }
    if (!_music) {
        _music = _musicModels[0];
    }
}

+ (AVAudioPlayer *)audioPlayerWithMusic:(YHHMusicModel *)music {
    // 获取音乐文件路径
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:music.fileName withExtension:nil];
    NSLog(@"%@",url);
    NSError *error = nil;
    
    // 如果已经有在播放的音乐，则不创建播放器
    if (_player) return _player;
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    // 设置播放循环次数
    _player.numberOfLoops = 0;
    
    if (error) {
        NSLog(@"----%@",error.localizedDescription);
        return nil;
    }
    [_player prepareToPlay];
    
    return _player;
}

+ (AVAudioPlayer *)playNextMusic {
    YHHMusicModel *music = [self nextMusic];
    NSURL *url = [[NSBundle mainBundle] URLForResource:_music.fileName withExtension:nil];
    NSLog(@"%@",url);
    NSError *error = nil;
    
    // 如果已经有在播放的音乐，则不创建播放器
    if (_player)  [_player stop];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    // 设置播放循环次数
    _player.numberOfLoops = 0;
    
    if (error) {
        NSLog(@"----%@",error.localizedDescription);
        return nil;
    }
    [_player prepareToPlay];
    
    return _player;

}

+ (AVAudioPlayer *)playPreviousMusic {
    YHHMusicModel *music = [self previousMusic];
    NSURL *url = [[NSBundle mainBundle] URLForResource:music.fileName withExtension:nil];
    NSLog(@"%@",url);
    NSError *error = nil;
    
    // 如果已经有在播放的音乐，则不创建播放器
    if (_player)  [_player stop];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    // 设置播放循环次数
    _player.numberOfLoops = 0;
    
    if (error) {
        NSLog(@"----%@",error.localizedDescription);
        return nil;
    }
    [_player prepareToPlay];
    
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
