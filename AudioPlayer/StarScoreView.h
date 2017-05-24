//
//  StarScoreView.h
//  AudioPlayer
//
//  Created by Yang on 2017/5/23.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarScoreView : UIView

@property (assign, nonatomic) CGFloat score;
@property (assign, nonatomic) CGFloat maxScore;

/* default starSize is (20,20) */
@property (assign, nonatomic) CGSize starSize;

@end
