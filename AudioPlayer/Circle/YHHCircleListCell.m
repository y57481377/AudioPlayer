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
    UIButton *_likeBtn;
    UIButton *_commentBtn;
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
    
    _likeBtn = [UIButton buttonWithTitle:@"喜欢" selectedTitle:nil image:nil selectedImage:nil target:self action:@selector(likeBtnClicked:)];
    _likeBtn.frame = CGRectMake(Auto_X(12), 0, Auto_X(60), 20);
    _likeBtn.backgroundColor = random_Color;
    [_likeBtn setTitleColor:black_Text_Color forState:UIControlStateNormal];
    [_likeBtn setTitleColor:red_Globe_Color forState:UIControlStateSelected];
    [_bottomView addSubview:_likeBtn];
    
    _commentBtn = [UIButton buttonWithTitle:@"" image:nil target:self action:@selector(commentBtnClicked:)];
    _commentBtn.frame = CGRectMake(_likeBtn.yhh_MaxX + 10, 0, _likeBtn.yhh_Width, 20);
    _commentBtn.backgroundColor = random_Color;
    [_bottomView addSubview:_commentBtn];
}

- (void)setModel:(YHHCircleModel *)model {
    _model = model;
    
    // 设置头像
    NSString *urlStr = [NSString stringWithFormat:@"http://web.hn-ssc.com/%@", model.headImagePath];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    [_headerImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Unknown5.25"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) return;
        
        [image circleImageCompleted:^(UIImage *circleImage) {
            _headerImage.image = circleImage;
        }];
    }];
    
    // 设置文字内容
    _contentLable.frame = CGRectMake(Auto_X(12), _headerImage.yhh_MaxY + Auto_Y(10), Screen_Width - Auto_X(24), 1);
    _contentLable.text = model.info;
    _contentLable.font = AutoFont(14);
    [_contentLable sizeToFit];
    
    // 设置展示的图片
    _imageCount = model.uploadFiles.count;
    [self layoutDisplayImages];
    
    // 设置喜欢的人图标
    _likedPeople = model.likeNum;
    [self layoutLikedPeople];
    
    if (_likedPeople > 0) _bottomView.yhh_Y = _likedPeopleIcons.yhh_MaxY + Auto_Y(10);
    else                  [self layoutViewByImageCount:_bottomView];
    
    // 当前circle article 是否喜欢
    _likeBtn.selected = model.isLikeCurrArticle;
    _likeBtn.userInteractionEnabled = YES;
    
    [_commentBtn setTitle:[NSString stringWithFormat:@"%ld", model.commentsNum]  forState:UIControlStateNormal];
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
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
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
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
    // 异步执行耗时的 循环
        NSArray *icons = _likedPeopleIcons.subviews;
        for (int i = 0; i < icons.count; i++) {
            UIButton *btn = [icons objectAtIndex:i];
            
            if (i < _likedPeople) {
                NSString *urlStr = [NSString stringWithFormat:@"http://web.hn-ssc.com/%@", _model.userArr[i][@"headImgId"]];
                NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
                
                [btn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[[UIImage imageNamed:@"Unknown5.25"] circleImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                    NSLog(@"%@",imageURL);
                    if (error) return;
                    [image circleImageCompleted:^(UIImage *circleImage) {
                        [btn setImage:circleImage forState:UIControlStateNormal];
                    }];
                }];
            }
            
            // 主线程设置UI
            dispatch_async(dispatch_get_main_queue(), ^{
                btn.hidden = !(i < _likedPeople);
            });
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
    // 限制用户连续点击 “喜欢”、刷新完毕后允许点击
    sender.userInteractionEnabled = NO;
    [self.protocol likeProtocolWithCell:self];
}

- (void)commentBtnClicked:(UIButton *)sender {
    NSLog(@"评论");
    [self.protocol commentProtocol:self];
}

@end
