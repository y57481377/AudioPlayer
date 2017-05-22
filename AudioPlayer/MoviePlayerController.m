//
//  MoviePlayerController.m
//  AudioPlayer
//
//  Created by Yang on 2017/4/28.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "MoviePlayerController.h"
#import <AVFoundation/AVFoundation.h>
@interface MoviePlayerController ()
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerItem *playerItem;

@end

@implementation MoviePlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.hidden = YES;
    
    self.view.backgroundColor = white_Text_Color;
    NSURL *url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
    _playerItem = [AVPlayerItem playerItemWithURL:url];
    
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil]; // 观察status属性
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
//    [_player addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil]; // 观察status属性]

    AVPlayerLayer *playLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canplay) name:AVPlayerItemNewAccessLogEntryNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stop) name:AVPlayerItemPlaybackStalledNotification object:nil];
    playLayer.frame = self.view.frame;
    [self.view.layer addSublayer:playLayer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"即将出现");
    [_player play];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"出现");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_player pause];
    NSLog(@"即将消失");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _player = nil;
    NSLog(@"消失");
}

- (void)canplay {
    NSLog(@"播放");
    [_player play];
}
 
- (void)stop {
    NSLog(@"停止");
    NSLog(@"empty:%d, full:%d ----- player:%ld",_playerItem.isPlaybackBufferEmpty, _playerItem.isPlaybackBufferFull, _player.status);
    [_player replaceCurrentItemWithPlayerItem:_playerItem];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"111");
    if ([keyPath isEqualToString:@"status"]) {
        NSLog(@"%@",[object class]);
        NSLog(@"%@",change);
        
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval loadedTime = [self loadedTime];
        
        NSLog(@"%lf",loadedTime);
        if (_playerItem.isPlaybackBufferFull) {
            NSLog(@"缓冲完成，继续播放");
            [_player play];
        }
    }
}


// 已经缓冲的区域
- (NSTimeInterval)loadedTime {
    NSArray *arr = _playerItem.loadedTimeRanges;
    CMTimeRange timeRange = [arr.firstObject CMTimeRangeValue];
    
    double startSecond = CMTimeGetSeconds(timeRange.start);
    double durationSecond = CMTimeGetSeconds(timeRange.duration);
    return startSecond + durationSecond;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_player play];
}

-(void)dealloc {
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
//    [_player removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
