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
@implementation YHHCircleListCell {
    UIImageView *_headerImage;
    UILabel *_nameLable;
    UILabel *_contentLable;
    
    NSInteger _imageCount;
    NSInteger _likedPeople;
    NSArray *_displayImages;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_X(12), Auto_Y(10), Auto_X(30), Auto_X(30))];
    _headerImage.backgroundColor = random_Color;
    [self addSubview:_headerImage];
    
    _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(_headerImage.yhh_MaxX + 5, Auto_Y(10), Auto_X(100), Auto_Y(20))];
    _nameLable.backgroundColor = random_Color;
    [self addSubview:_nameLable];
    
    _contentLable = [[UILabel alloc] init];
    _contentLable.font = AutoFont(15);
    _contentLable.numberOfLines = 0;
    _contentLable.backgroundColor = random_Color;
    [self addSubview:_contentLable];
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIImageView *imagev = [[UIImageView alloc] init];
//        imagev.contentMode = UIcontemode
        imagev.backgroundColor = random_Color;
        [images addObject:imagev];
    }
    _displayImages = [NSArray arrayWithArray:images];
    
}

- (void)setModel:(YHHCircleModel *)model {
    _model = model;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", model.headImagePath]];
    [_headerImage sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage]];
    
    _contentLable.frame = CGRectMake(Auto_X(12), _headerImage.yhh_MaxY + 5, Screen_Width - Auto_X(24), 1);
    _contentLable.text = model.info;
    _contentLable.font = AutoFont(14);
    [_contentLable sizeToFit];
    
    _imageCount = model.uploadFiles.count;
    [self layoutDisplayImages];
}

- (void)layoutDisplayImages {
    for (int i = 0; i < _displayImages.count; i++) {
        UIImageView *imagev = _displayImages[i];
        [imagev removeFromSuperview];
        
        if (_imageCount == 0) continue;
        if (_imageCount <= 2) {
            if (i != 0) continue;
            imagev.frame = CGRectMake(Auto_X(12), _contentLable.yhh_MaxY + 5, Screen_Width - Auto_X(24), Auto_Y(120));
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.uploadFiles[i][@"accessPath"]]];
            [imagev sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage]];
            [self addSubview:imagev];
        }else {
            if (i == 0) {
                imagev.frame = CGRectMake(Auto_X(12), _contentLable.yhh_MaxY + 5, (Screen_Width - Auto_X(36)) *0.6, Auto_Y(120));
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.uploadFiles[i][@"accessPath"]]];
                [imagev sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage]];
            }else {
                imagev.frame = CGRectMake((Screen_Width - Auto_X(36)) *0.6 + Auto_X(24), _contentLable.yhh_MaxY + 5 + Auto_Y(66)*(i-1), (Screen_Width - Auto_X(36)) *0.4, Auto_Y(54));
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.uploadFiles[i][@"accessPath"]]];
                [imagev sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage]];
            }
            [self addSubview:imagev];
            
            if (i == 2) break;
        }
        
    }
}
@end
