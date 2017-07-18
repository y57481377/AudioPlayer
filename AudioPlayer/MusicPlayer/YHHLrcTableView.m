//
//  YHHLrcTableView.m
//  AudioPlayer
//
//  Created by Yang on 17/4/24.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHLrcTableView.h"
#import "YHHMusicTool.h"
#import "YHHLrcModel.h"
@interface YHHLrcTableView() <UITableViewDataSource>
@property (strong, nonatomic) NSArray *lrcs;
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation YHHLrcTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _lrcs = [YHHLrcModel getLrcsWithMusic:[YHHMusicTool playingMusic]];
        self.dataSource = self;
        self.rowHeight = 30;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat h = self.frame.size.height;
    self.contentInset = UIEdgeInsetsMake(h/2, 0, h/2, 0);
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lrcs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lrcCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lrcCell"];
    }
    YHHLrcModel *lrc = _lrcs[indexPath.row];
    if (indexPath.row == _currentIndex) {
        cell.textLabel.font = AutoFont(16);
        cell.textLabel.textColor = red_Globe_Color;
    }else {
        cell.textLabel.font = AutoFont(15);
        cell.textLabel.textColor = white_Text_Color;
    }
    
    cell.textLabel.text = lrc.text;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

// 设置歌词
- (void)setMusic:(YHHMusicModel *)music {
    _music = music;
    _lrcs = [YHHLrcModel getLrcsWithMusic:music];
    _currentIndex = 0;
    [self reloadData];
}

// 根据当前播放时间刷新歌词
- (void)setCurrentTime:(NSTimeInterval)currentTime {
    _currentTime = currentTime;
    YHHLrcModel *lrc;
    YHHLrcModel *nlrc;
    for (int i = 0; i < _lrcs.count; i++) {
        lrc = _lrcs[i];
        
        if (i + 1 <= _lrcs.count - 1) {
            nlrc = _lrcs[i + 1];
        }
        
        if (lrc.time <= currentTime && (nlrc.time >= currentTime || (i + 1) == _lrcs.count -1)) {
            if (_currentIndex == i) return;
            // 刷新当前歌词，和已过的歌词
            NSIndexPath *previousIndex = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
            NSIndexPath *currentIndex = [NSIndexPath indexPathForRow:i inSection:0];
            _currentIndex = i;
            [self reloadRowsAtIndexPaths:@[currentIndex, previousIndex] withRowAnimation:UITableViewRowAnimationNone];
            [self scrollToRowAtIndexPath:currentIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        }
    }
}

@end
