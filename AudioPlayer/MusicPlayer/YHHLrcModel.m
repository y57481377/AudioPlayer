//
//  YHHMusicLrcModel.m
//  AudioPlayer
//
//  Created by Yang on 17/4/21.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHLrcModel.h"
#import "YHHMusicModel.h"
@implementation YHHLrcModel

+ (NSArray *)getLrcsWithMusic:(YHHMusicModel *)music {
    NSURL *lrcUrl = [[NSBundle mainBundle] URLForResource:music.lrcName withExtension:nil];
    
    NSArray *arr = [[NSString stringWithContentsOfURL:lrcUrl encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByString:@"\n"];
    NSMutableArray *lrcs = [NSMutableArray array];
    
    for (NSString *str in arr) {
        NSLog(@"%@",str);
        if (str.length < 1) continue;
            
        NSArray *msg = [str componentsSeparatedByString:@"]"];
        YHHLrcModel *model = [[self alloc] init];
        NSInteger min = [[msg firstObject] substringWithRange:NSMakeRange(1, 2)].integerValue;
        double sec = [[msg firstObject] substringFromIndex:4].doubleValue;
        model.time = min * 60 + sec;
        model.text = [msg lastObject];
        [lrcs addObject:model];
    }
    return lrcs;
}

@end
