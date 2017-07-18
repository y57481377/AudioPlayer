//
//  YHHMusicModel.m
//  AudioPlayer
//
//  Created by Yang on 17/4/21.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHMusicModel.h"

@implementation YHHMusicModel

+ (NSArray *)getMusics {
    NSURL *musicUrl = [[NSBundle mainBundle] URLForResource:@"music.plist" withExtension:nil];
    
    NSArray *arr = [NSArray arrayWithContentsOfURL:musicUrl];
    NSMutableArray *musics = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        
        YHHMusicModel *model = [[self alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [musics addObject:model];
    }
    
    return musics;
}

@end
