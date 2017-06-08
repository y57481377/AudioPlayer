//
//  YHHCircleListCell.h
//  AudioPlayer
//
//  Created by Yang on 2017/5/25.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHHCircleListCell;
@protocol CircleCellProtocol <NSObject>

- (void)commentProtocol:(YHHCircleListCell *)cell;

- (void)likeProtocolWithCell:(YHHCircleListCell *)cell;

@end

@class YHHCircleModel;
@interface YHHCircleListCell : UITableViewCell

@property (strong, nonatomic) YHHCircleModel *model;

@property (weak, nonatomic) id<CircleCellProtocol> protocol;
@end
