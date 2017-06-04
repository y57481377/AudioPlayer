//
//  YHHCircleListCell.m
//  AudioPlayer
//
//  Created by Yang on 2017/5/25.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHCircleListCell.h"
#import "YHHCircleModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
@implementation YHHCircleListCell {
    UIImageView *_headerImage;
    UILabel *_nameLable;
    UILabel *_contentLable;
//    UIButton *_showLikedPeople;
    
    NSInteger _imageCount;
    NSArray *_displayImages;
    NSInteger _likedPeople;
    NSArray *_likedPeopleIcons;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_X(12), Auto_Y(10), Auto_X(40), Auto_X(40))];
    _headerImage.contentMode = UIViewContentModeScaleAspectFill;
    _headerImage.backgroundColor = random_Color;
    [self.contentView addSubview:_headerImage];
    
    _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(_headerImage.yhh_MaxX + 5, Auto_Y(10), Auto_X(100), Auto_Y(20))];
    _nameLable.backgroundColor = random_Color;
    [self.contentView addSubview:_nameLable];
    
    _contentLable = [[UILabel alloc] init];
    _contentLable.font = AutoFont(15);
    _contentLable.numberOfLines = 0;
    _contentLable.backgroundColor = random_Color;
    [self.contentView addSubview:_contentLable];
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIImageView *imagev = [[UIImageView alloc] init];
        imagev.contentMode = UIViewContentModeScaleAspectFill;
        imagev.clipsToBounds = YES;
        imagev.backgroundColor = random_Color;
        [images addObject:imagev];
        [self.contentView addSubview:imagev];
    }
    _displayImages = [NSArray arrayWithArray:images];
    
    NSMutableArray *icons = [NSMutableArray array];
    CGFloat x = Auto_X(12);
    for (int i = 0; i < 10; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, Auto_Y(50), Auto_Y(30), Auto_Y(30));
        btn.backgroundColor = random_Color;
        
        [icons addObject:btn];
        [self.contentView addSubview:btn];
        
        x += Auto_Y(30) + 4;
    }
    _likedPeopleIcons = [NSArray arrayWithArray:icons];
    
}

- (void)setModel:(YHHCircleModel *)model {
    _model = model;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", model.headImagePath]];
    [_headerImage sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) _headerImage.image = [image circleImage];
    }];
    
    _contentLable.frame = CGRectMake(Auto_X(12), _headerImage.yhh_MaxY + Auto_Y(10), Screen_Width - Auto_X(24), 1);
    _contentLable.text = model.info;
    _contentLable.font = AutoFont(14);
    [_contentLable sizeToFit];
    
    _imageCount = model.uploadFiles.count;
    [self layoutDisplayImages];
    
//    _likedPeople = model.likeNum.integerValue;
//    NSLog(@"%@---%@",_likedPeople, model.userArr);
//    [self layoutLikedPeople];
}

/** 
 通过图片数量计算展现图片等样式、
 0:    不展示图片内容隐藏图片，
 1～2: 展示一张图片，
 3～n: 展示3张图片。
 */
- (void)layoutDisplayImages {
    for (int i = 0; i < _displayImages.count; i++) {
        UIImageView *imagev = _displayImages[i];
//        [imagev removeFromSuperview];
        imagev.hidden = YES;
        
        if (_imageCount == 0) continue;
        if (_imageCount <= 2) {
            if (i != 0) continue;
            imagev.frame = CGRectMake(Auto_X(12), _contentLable.yhh_MaxY + Auto_Y(10), Screen_Width - Auto_X(24), Auto_Y(140));
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.uploadFiles[i][@"accessPath"]]];
            [imagev sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage]];
//            [self.contentView addSubview:imagev];
            imagev.hidden = NO;
        }else {
            if (i == 0) {
                imagev.frame = CGRectMake(Auto_X(12), _contentLable.yhh_MaxY + Auto_Y(10), (Screen_Width - Auto_X(36)) *0.6, Auto_Y(140));
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.uploadFiles[i][@"accessPath"]]];
                [imagev sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage]];
            }else {
                imagev.frame = CGRectMake((Screen_Width - Auto_X(36)) *0.6 + Auto_X(24), _contentLable.yhh_MaxY + Auto_Y(10) + Auto_Y(76)*(i-1), (Screen_Width - Auto_X(36)) *0.4, Auto_Y(64));
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.uploadFiles[i][@"accessPath"]]];
                [imagev sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage]];
            }
//            [self.contentView addSubview:imagev];
            imagev.hidden = NO;
            
            if (i == 2) break;
        }
        
    }
}

/**
 计算喜欢人数图标展示个数，
 0:     不显示喜欢的人的头像，
 1～10: 显示当前喜欢的人的头像，
 10～n: 显示10个最新喜欢的人的头像，末尾添加一个"..."图标点击可查看所有喜欢的人
*/
- (void)layoutLikedPeople{
    
//    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, DISPATCH_QUEUE_PRIORITY_DEFAULT);
//    dispatch_async(queue, ^{
    
        for (int i = 0; i < _likedPeopleIcons.count; i++) {
            UIButton *btn = [_likedPeopleIcons objectAtIndex:i];
            btn.yhh_Y = _contentLable.yhh_MaxY + (_imageCount > 0 ? Auto_Y(160) : Auto_Y(10));
            
            if (i < _likedPeople) {
                btn.hidden = NO;
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.userArr[i][@"headImgId"]]];
                [btn sd_setImageWithURL:url forState:UIControlStateNormal];
            }else {
                btn.hidden = YES;
            }
        };
        
//    });
}

@end
