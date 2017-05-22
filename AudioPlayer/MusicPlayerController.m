//
//  ViewController.m
//  AudioPlayer
//
//  Created by Yang on 17/4/20.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "MusicPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "YHHMusicTool.h"
#import "YHHMusicModel.h"
#import "YHHLrcModel.h"
#import "YHHLrcTableView.h"
#import "UIImage+Extention.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MusicPlayerController ()<AVAudioPlayerDelegate>

@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (weak, nonatomic) IBOutlet UISlider *progress;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) CADisplayLink *lrcLink;

@property (strong, nonatomic) YHHMusicModel *music;

@property (weak, nonatomic) IBOutlet UILabel *durationLab;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLab;
@property (weak, nonatomic) IBOutlet UILabel *singerLab;
@property (weak, nonatomic) IBOutlet UIImageView *diskImage;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet YHHLrcTableView *lrcView;

@end

@implementation MusicPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setNavBarColor:[UIColor clearColor]];
    [self setNavBarShadowColor:white_Text_Color];
    
    _music = [YHHMusicTool playingMusic];
    _player = [YHHMusicTool audioPlayerWithMusic:_music];
    _playerItem = _player.currentItem;
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self setupMusic];

}

- (void)viewWillLayoutSubviews {
    // 光盘背景view
    _diskImage.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    _diskImage.layer.cornerRadius = _diskImage.bounds.size.width / 2;
    _diskImage.layer.borderWidth = 10;
    _diskImage.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1].CGColor;
    _diskImage.layer.masksToBounds = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self invalidateTimer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 初始化界面
- (void)setupMusic {
    
    //切换音乐需要初始化的数据
    _musicNameLab.text = _music.name;
    _singerLab.text = _music.singer;
    
    _playerItem = _player.currentItem;
    _currentTimeLab.text = [self timeStrWithTimeInterval:CMTimeGetSeconds(_playerItem.currentTime)];
    _durationLab.text = [self timeStrWithTimeInterval:CMTimeGetSeconds(_playerItem.duration)];
    _progress.value = CMTimeGetSeconds(_playerItem.currentTime) / CMTimeGetSeconds(_playerItem.duration);
}

#pragma mark --- 初始化player
// 展示歌词
- (IBAction)tapShowLrc:(UITapGestureRecognizer *)sender {
    _backView.userInteractionEnabled = !_backView.userInteractionEnabled;
    [UIView animateWithDuration:0.4 animations:^{
        CGFloat alp = _backView.userInteractionEnabled ? 1.0 : 0;
        _backView.alpha = alp;
        _lrcView.alpha = 1 - alp;
    }];
}

- (void)startPlayingMusic {
//    _player.delegate = self;
    
    [self setupMusic];
    
    [self invalidateTimer];
    [self startTimer];
    [_player play];
    
    [self setupLockedView];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        NSLog(@"1");
        [self playNext:nil];
    }else {
        NSLog(@"2");
    }
}


#pragma mark --- 播放控制
- (IBAction)playBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"播放");
        [self startPlayingMusic];
    }else {
        NSLog(@"暂停");
        [_player pause];
        [self invalidateTimer];
    }
}

- (IBAction)playNext:(UIButton *)sender {
    NSLog(@"下一首");
//    _player = nil;
    _player = [YHHMusicTool playNextMusic];
    _music = [YHHMusicTool playingMusic];
    _lrcView.music = _music;
    [self startPlayingMusic];
}

- (IBAction)playBefore:(UIButton *)sender {
    NSLog(@"上一首");
//    [_player stop];
//     = nil;
    _player = [YHHMusicTool playPreviousMusic];
    _music = [YHHMusicTool playingMusic];
    _lrcView.music = _music;
    [self startPlayingMusic];
}

- (IBAction)progressValueChange:(UISlider *)sender {
    _currentTimeLab.text = [self timeStrWithTimeInterval:CMTimeGetSeconds(_playerItem.duration) * sender.value];
}

// 开始拖动进度条
- (IBAction)progressTouchesBegin:(UISlider *)sender {
    [self invalidateTimer];
    NSLog(@"开始拖动");
}

// 结束拖动进度条
- (IBAction)progressTouchesEnd:(UISlider *)sender {
    
    NSTimeInterval toTime = CMTimeGetSeconds(_playerItem.duration) * sender.value;
//    CMTimeScale scale = _playerItem.currentTime.timescale;
    CMTime time = CMTimeMakeWithSeconds(toTime, 1);
    [_playerItem seekToTime:time];
    _currentTimeLab.text = [self timeStrWithTimeInterval:CMTimeGetSeconds(time)];
    [self startTimer];
    NSLog(@"%f",sender.value);
}


#pragma mark --- 定时器
- (void)startTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    if (!_lrcLink) {
        _lrcLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshLrc)];
        _lrcLink.frameInterval = 2;
        [_lrcLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)invalidateTimer {
    [_timer invalidate];
    _timer = nil;
    [_lrcLink invalidate];
    _lrcLink = nil;
}

- (void)refreshProgress {
    NSLog(@"刷新");
    _currentTimeLab.text = [self timeStrWithTimeInterval:CMTimeGetSeconds(_playerItem.currentTime)];
    _progress.value = CMTimeGetSeconds(_playerItem.currentTime) / CMTimeGetSeconds(_playerItem.duration);
}

- (void)refreshLrc {
    _lrcView.currentTime = CMTimeGetSeconds(_playerItem.currentTime);
}

// 转换timeInterval 成00:00格式字符串
- (NSString *)timeStrWithTimeInterval:(NSTimeInterval)interval {
    NSInteger min = interval / 60;
    NSInteger sec = (NSInteger)interval % 60;
    NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    return timeStr;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval loadedTime = [self loadedTime];
        
    }
}

- (NSTimeInterval)loadedTime {
    NSArray *arr = _playerItem.loadedTimeRanges;
    CMTimeRange timeRange = [arr.firstObject CMTimeRangeValue];
    
    double startSecond = CMTimeGetSeconds(timeRange.start);
    double durationSecond = CMTimeGetSeconds(timeRange.duration);
    return startSecond + durationSecond;
}

- (void)setupLockedView {
    YHHMusicModel *playingMusic = [YHHMusicTool playingMusic];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:playingMusic.name forKey:MPMediaItemPropertyTitle];
    [dic setObject:playingMusic.singer forKey:MPMediaItemPropertyArtist];
    [dic setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(_playerItem.currentTime)] forKey:MPMediaItemPropertyPlaybackDuration];
    [dic setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(_playerItem.duration)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = dic;
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    
    if (event.type==UIEventTypeRemoteControl) {
        
        NSLog(@"%ld",event.subtype);
        
    }
}

@end
