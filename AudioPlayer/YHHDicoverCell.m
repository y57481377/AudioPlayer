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
    _headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, Auto_Y(10), Auto_X(80), Auto_Y(100))];
    _headerImage.backgroundColor = [UIColor cyanColor];
    [self addSubview:_headerImage];
    
    _starsView = [[StarScoreView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    _starsView.starSize = CGSizeMake(40, 40);
    _starsView.score = 3.3;
//    _starsView.scoreLabel.text = [NSString stringWithFormat:@"评分%f",3.5];
    [self addSubview:_starsView];
    
}

- (void)setModel:(YHHDiscoverModel *)model {
    _model = model;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
