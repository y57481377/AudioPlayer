//
//  YHHLrcTableView.h
//  AudioPlayer
//
//  Created by Yang on 17/4/24.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHHMusicModel;
@interface YHHLrcTableView : UITableView

@property (assign, nonatomic) NSTimeInterval currentTime;

@property (strong, nonatomic) YHHMusicModel *music;
@end
