//
//  YHHMusicModel.h
//  AudioPlayer
//
//  Created by Yang on 17/4/21.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHHMusicModel : NSObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *fileName;

@property (strong, nonatomic) NSString *singer;

@property (strong, nonatomic) NSString *musicIcon;

@property (strong, nonatomic) NSString *lrcName;

+ (NSArray *)getMusics;

@end
