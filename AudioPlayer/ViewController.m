//
//  ViewController.m
//  AudioPlayer
//
//  Created by Yang on 17/4/20.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YHHMusicTool.h"
#import "YHHMusicModel.h"
#import "YHHMusicLrcModel.h"
#import "UIImage+Extention.h"

#define yhhColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
@interface ViewController ()<AVAudioPlayerDelegate>

@property (strong, nonatomic) AVPlayer *player1;
@property (strong, nonatomic) AVAudioPlayer *player;

@property (weak, nonatomic) IBOutlet UISlider *progress;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) YHHMusicModel *music;

@property (weak, nonatomic) IBOutlet UILabel *durationLab;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLab;
@property (weak, nonatomic) IBOutlet UILabel *singerLab;
@property (weak, nonatomic) IBOutlet UIImageView *diskImage;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage yhh_imageWithColor:yhhColor(191, 191, 191, 1)]];
    _music = [YHHMusicTool playingMusic];
    
    [self startPlayingMusic];
    
    
    
}

- (void)viewWillLayoutSubviews {
    _diskImage.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    _diskImage.layer.cornerRadius = _diskImage.bounds.size.width / 2;
    _diskImage.layer.borderWidth = 10;
    _diskImage.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1].CGColor;
    _diskImage.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --- 初始化player
- (AVAudioPlayer *)audioPlayerWithMusic:(NSString *)fileName {
    // 获取音乐文件路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    NSLog(@"%@",url);
    NSError *error = nil;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    // 设置播放循环次数
    audioPlayer.numberOfLoops = 0;
    
    if (error) {
        NSLog(@"----%@",error.localizedDescription);
        return nil;
    }
    [audioPlayer prepareToPlay];
    
    return audioPlayer;
}

// 展示歌词
- (IBAction)tapShowLrc:(UITapGestureRecognizer *)sender {
}

- (void)startPlayingMusic {
    _player = [self audioPlayerWithMusic:_music.fileName];
    _player.delegate = self;
    
    //切换音乐需要初始化的数据
    _musicNameLab.text = _music.name;
    _singerLab.text = _music.singer;
    _currentTimeLab.text = @"00:00";
    _durationLab.text = [self timeStrWithTimeInterval:_player.duration];
    _progress.value = 0.0;
    
    [self startTimer];
    [_player play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        NSLog(@"1");
        _music = [YHHMusicTool nextMusic];
        [self startPlayingMusic];
        [_player play];
    }else {
        NSLog(@"2");
    }
}


#pragma mark --- 播放控制
- (IBAction)playBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"暂停");
        [_player pause];
        [self invalidateTimer];
    }else {
        NSLog(@"播放");
        [_player play];
        _currentTimeLab.text = [self timeStrWithTimeInterval:_player.currentTime];
        [self startTimer];
    }
}

- (IBAction)playNext:(UIButton *)sender {
    NSLog(@"下一首");
    [_player stop];
    _player = nil;
    _music = [YHHMusicTool nextMusic];
    [self startPlayingMusic];
}

- (IBAction)playBefore:(UIButton *)sender {
    NSLog(@"上一首");
    [_player stop];
    _player = nil;
    _music = [YHHMusicTool previousMusic];
    [self startPlayingMusic];
}

- (IBAction)progressValueChange:(UISlider *)sender {
    _currentTimeLab.text = [self timeStrWithTimeInterval:_player.duration * sender.value];
    
}

// 开始拖动进度条
- (IBAction)progressTouchesBegin:(UISlider *)sender {
    [self invalidateTimer];
    NSLog(@"开始拖动");
}

// 结束拖动进度条
- (IBAction)progressTouchesEnd:(UISlider *)sender {
    _player.currentTime = _player.duration *sender.value;
    _currentTimeLab.text = [self timeStrWithTimeInterval:_player.currentTime];
    [self startTimer];
    NSLog(@"%f",sender.value);
}


#pragma mark --- 定时器
- (void)startTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)invalidateTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)refreshProgress {
    NSLog(@"刷新");
    _currentTimeLab.text = [self timeStrWithTimeInterval:_player.currentTime];
    _progress.value = _player.currentTime / _player.duration;
}

// 转换timeInterval 成00:00格式字符串
- (NSString *)timeStrWithTimeInterval:(NSTimeInterval)interval {
    NSInteger min = interval / 60;
    NSInteger sec = (NSInteger)interval % 60;
    NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    return timeStr;
}
@end
