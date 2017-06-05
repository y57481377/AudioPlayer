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
    
    //放置 点赞、评论btn的容器
    UIView *_bottomView;
    
    //内容image
    NSInteger _imageCount;
    UIView *_displayImages;
    UIImageView *_displayOne;
    
    //喜欢的人icon
    NSInteger _likedPeople;
    UIView *_likedPeopleIcons;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    // 头像
    _headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_X(12), Auto_Y(10), Auto_X(40), Auto_X(40))];
    _headerImage.contentMode = UIViewContentModeScaleAspectFill;
    _headerImage.backgroundColor = random_Color;
    [self.contentView addSubview:_headerImage];
    
    // 昵称
    _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(_headerImage.yhh_MaxX + 5, Auto_Y(10), Auto_X(100), Auto_Y(20))];
    _nameLable.backgroundColor = random_Color;
    [self.contentView addSubview:_nameLable];
    
    // 文字内容
    _contentLable = [[UILabel alloc] init];
    _contentLable.font = AutoFont(15);
    _contentLable.numberOfLines = 0;
    _contentLable.backgroundColor = random_Color;
    [self.contentView addSubview:_contentLable];
    
    // 需要展示的图片 _displayOne展示一张，_displayImages展示3张。
    _displayOne = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_X(12), 0, Screen_Width - Auto_X(24), Auto_Y(200))];
    _displayOne.contentMode = UIViewContentModeScaleAspectFill;
    _displayOne.clipsToBounds = YES;
    [self.contentView addSubview:_displayOne];
    
    _displayImages = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Auto_Y(150))];
    [self.contentView addSubview:_displayImages];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imagev = [[UIImageView alloc] init];
        
        if (i == 0) {
            imagev.frame = CGRectMake(Auto_X(12), 0, (Screen_Width - Auto_X(36)) *0.6, Auto_Y(150));
        }else {
            imagev.frame = CGRectMake((Screen_Width - Auto_X(36)) *0.6 + Auto_X(24), Auto_Y(81)*(i-1), (Screen_Width - Auto_X(36)) *0.4, Auto_Y(69));
        }
        imagev.contentMode = UIViewContentModeScaleAspectFill;
        imagev.clipsToBounds = YES;
        imagev.backgroundColor = random_Color;
        [_displayImages addSubview:imagev];
    }
    
    // 喜欢的人的图标
    _likedPeopleIcons = [[UIView alloc] initWithFrame:CGRectMake(Auto_X(12), 0, Screen_Width - Auto_X(24), Auto_Y(30))];
    [self.contentView addSubview:_likedPeopleIcons];
    
    CGFloat x = 0;
    for (int i = 0; i < 10; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, 0, Auto_Y(30), Auto_Y(30));
        btn.backgroundColor = random_Color;
        
        [_likedPeopleIcons addSubview:btn];
        x += Auto_Y(30) + 4;
    }
    
    //  点赞（喜欢）、评论
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, Screen_Width, 20)];
    [self.contentView addSubview:_bottomView];
    
    UIButton *likeBtn = [UIButton buttonWithTitle:@"喜欢" selectedTitle:nil image:nil selectedImage:nil target:self action:@selector(likeBtnClicked:)];
    likeBtn.frame = CGRectMake(Auto_X(12), 0, Auto_X(60), 20);
    likeBtn.backgroundColor = random_Color;
    [likeBtn setTitleColor:black_Text_Color forState:UIControlStateNormal];
    [likeBtn setTitleColor:red_Globe_Color forState:UIControlStateSelected];
    [_bottomView addSubview:likeBtn];
    
    UIButton *commentBtn = [UIButton buttonWithTitle:@"" image:nil target:self action:@selector(commentBtnClicked:)];
    commentBtn.frame = CGRectMake(likeBtn.yhh_MaxX + 10, 0, likeBtn.yhh_Width, 20);
    commentBtn.backgroundColor = random_Color;
    [_bottomView addSubview:commentBtn];
}

- (void)setModel:(YHHCircleModel *)model {
    _model = model;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", model.headImagePath]];
    [_headerImage sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage]];
    [_headerImage circle];
    
    _contentLable.frame = CGRectMake(Auto_X(12), _headerImage.yhh_MaxY + Auto_Y(10), Screen_Width - Auto_X(24), 1);
    _contentLable.text = model.info;
    _contentLable.font = AutoFont(14);
    [_contentLable sizeToFit];
    
    _imageCount = model.uploadFiles.count;
    [self layoutDisplayImages];
    
    _likedPeople = model.likeNum.integerValue;
    [self layoutLikedPeople];
    
    if (_likedPeople > 0) _bottomView.yhh_Y = _likedPeopleIcons.yhh_MaxY + Auto_Y(10);
    else                  [self layoutViewByImageCount:_bottomView];
    
}

/** 
 通过图片数量计算展现图片等样式、
 0:    不展示图片内容隐藏图片，
 1～2: 展示一张图片，
 3～n: 展示3张图片。
 */
- (void)layoutDisplayImages {
    
    BOOL hidden = (_imageCount == 0);
    _displayOne.hidden = hidden;
    _displayImages.hidden = hidden;
    if (hidden) return;
    
    _displayOne.yhh_Y = _displayImages.yhh_Y = _contentLable.yhh_MaxY + Auto_Y(10);
    
    BOOL onlyOne = (!hidden && _imageCount < 3);
    _displayOne.hidden = !onlyOne;
    _displayImages.hidden = onlyOne;
    
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, DISPATCH_QUEUE_PRIORITY_DEFAULT);
    dispatch_async(queue, ^{
        if (onlyOne) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.uploadFiles[0][@"accessPath"]]];
            [_displayOne sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage]];
        }else {
            NSArray *images = _displayImages.subviews;
            for (int i = 0; i < images.count; i++) {
                UIImageView *imagev = images[i];
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.uploadFiles[i][@"accessPath"]]];
                [imagev sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage]];
            }
        }
    });
}

/**
 计算喜欢人数图标展示个数，
 0:     不显示喜欢的人的头像，
 1～10: 显示当前喜欢的人的头像，
 10～n: 显示10个最新喜欢的人的头像，末尾添加一个"..."图标点击可查看所有喜欢的人
*/
- (void)layoutLikedPeople{
    
    BOOL hidden = (_likedPeople == 0);
    _likedPeopleIcons.hidden = hidden;
    if (hidden) return;
    
    [self layoutViewByImageCount:_likedPeopleIcons];
    
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, DISPATCH_QUEUE_PRIORITY_DEFAULT);
    dispatch_async(queue, ^{
    
        NSArray *icons = _likedPeopleIcons.subviews;
        for (int i = 0; i < icons.count; i++) {
            UIButton *btn = [icons objectAtIndex:i];
            
            if (i < _likedPeople) {
                btn.hidden = NO;
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.userArr[i][@"headImgId"]]];
                [btn sd_setImageWithURL:url forState:UIControlStateNormal];
            }else {
                btn.hidden = YES;
            }
        };
        
    });

}

- (void)layoutViewByImageCount:(UIView *)view {
    CGFloat y = Auto_Y(10);
    if (_imageCount > 0 && _imageCount < 3)
        view.yhh_Y = _displayOne.yhh_MaxY + y;
    else if (_imageCount >= 3)
        view.yhh_Y = _displayImages.yhh_MaxY + y;
    else
        view.yhh_Y = _contentLable.yhh_MaxY + y;
}

- (void)likeBtnClicked:(UIButton *)sender {
    NSLog(@"喜欢");
}

- (void)commentBtnClicked:(UIButton *)sender {
    NSLog(@"评论");
}

@end
