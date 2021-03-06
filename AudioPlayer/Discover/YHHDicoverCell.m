//
//  YHHDicoverCell.m
//  AudioPlayer
//
//  Created by Yang on 2017/5/23.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHDicoverCell.h"
#import "StarScoreView.h"
@implementation YHHDicoverCell {
    UIImageView *_headerImage;
    UILabel *_titleLabel;
    UILabel *_tagsLabel;
    StarScoreView *_starsView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    NSLog(@"创建cell");
    _headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, Auto_Y(10), Auto_Y(80), Auto_Y(80))];
    _headerImage.backgroundColor = [UIColor cyanColor];
    
    [_headerImage circle];
    [self addSubview:_headerImage];
    
    CGFloat x = 120;
    CGFloat y = Auto_Y(10);
    for (int i = 0; i < 10; i++) {
        x = 120 + (Auto_Y(40) + 5) * (i%5);
        y = Auto_Y(10) + (Auto_Y(40) + 5) * (int)(i/5);
        UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, Auto_Y(40), Auto_Y(40))];
        imagev.contentMode = UIViewContentModeScaleAspectFill;
        // 把image设置为圆形
        UIImage *image = [UIImage imageNamed:@"Unknown5.25"];
        [image circleImageCompleted:^(UIImage *circleImage) {
            imagev.image = circleImage;
        }];
        
        imagev.backgroundColor = random_Color;
        [self addSubview:imagev];
    }
    self.backgroundColor = random_Color;
    _starsView = [[StarScoreView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    _starsView.starSize = CGSizeMake(40, 40);
    _starsView.score = 3.3;
//    _starsView.scoreLabel.text = [NSString stringWithFormat:@"评分%f",3.5];
//    [self addSubview:_starsView];
    
}

- (void)layoutSubviews {
    [self setCornerRadius:10];
}

- (void)setModel:(YHHDiscoverModel *)model {
    _model = model;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
