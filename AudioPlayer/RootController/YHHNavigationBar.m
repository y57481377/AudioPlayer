//
//  YHHNavigationBar.m
//  AudioPlayer
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHNavigationBar.h"

#define centerY self.yhh_Height / 2 + 10
#define MarginX 15
@implementation YHHNavigationBar {
    UIView *_shadow;
}
- (instancetype)init {
    if (self = [super initWithFrame:CGRectMake(0, 0, Screen_Width, 64.f)]) {
//        [self creatUI];
    }
    return self;
}

//- (void)creatUI {

//    _shadow = [[UIView alloc] initWithFrame:CGRectMake(0, self.yhh_Height - 1, self.yhh_Width, 1)];
//    _shadow.backgroundColor = [UIColor clearColor];
//    [self addSubview:_shadow];
//}

// 导航栏返回按钮
- (void)setBackItem:(UIButton *)backItem {
    _backItem = backItem;
    _backItem.titleLabel.font = [UIFont systemFontOfSize:15];
    _backItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 设置较宽的属性，方便点击
    _backItem.bounds = CGRectMake(0, 0, 50, 22);
    _backItem.center = CGPointMake(_backItem.yhh_Width / 2 + MarginX, centerY);
    [self addSubview:_backItem];
}

- (void)setLeftItem:(UIButton *)leftItem {
    _leftItem = leftItem;
    _leftItem.bounds = CGRectMake(0, 0, _leftItem.yhh_Width / _leftItem.yhh_Height * 22, 22);
    _leftItem.center = CGPointMake(leftItem.yhh_Width / 2 + MarginX, centerY);
    
    // 如果有设置导航栏左键，则移除返回按钮
    [_backItem removeFromSuperview];
    [self addSubview:_leftItem];
}

- (void)setLeftItems:(NSArray *)leftItems {
    _leftItems = leftItems;
    
    CGFloat f = 0;
    for (int i = 0; i < _leftItems.count; i++) {
        UIButton *btn = _leftItems[i];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        btn.bounds = CGRectMake(0, 0, btn.yhh_Width / btn.yhh_Height * 22, 22);
        CGFloat x =  btn.yhh_Width / 2 + f;
        btn.center = CGPointMake(x + MarginX , centerY);
        
        // 每个item之间间隔8
        f += btn.yhh_Width + 8;
        NSLog(@"%@",NSStringFromCGRect(btn.frame));
        [self addSubview:btn];
    }
}

- (void)setRightItem:(UIButton *)rightItem {
    _rightItem = rightItem;
    _rightItem.bounds = CGRectMake(0, 0, _rightItem.yhh_Width / _rightItem.yhh_Height * 22, 22);
    _rightItem.center = CGPointMake(self.yhh_Width - (_rightItem.yhh_Width / 2 + MarginX), centerY);
    [self addSubview:_rightItem];
}

- (void)setRightItems:(NSArray *)rightItems {
    _rightItems = rightItems;
    
    CGFloat f = 0;
    for (int i = 0; i < _rightItems.count; i++) {
        UIButton *btn = _rightItems[i];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        btn.bounds = CGRectMake(0, 0, btn.yhh_Width / btn.yhh_Height * 22, 22);
        CGFloat x = self.yhh_Width - btn.yhh_Width / 2 - f;
        btn.center = CGPointMake(x - MarginX , centerY);
        
        // 每个item之间间隔8
        f += btn.yhh_Width + 8;
        NSLog(@"%@",NSStringFromCGRect(btn.frame));
        [self addSubview:btn];
    }
}

- (void)setTitle:(NSString *)title {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    _titleLabel.text = title;
}

- (void)setShadowColor:(UIColor *)color {
    if (!_shadow) {
        _shadow = [[UIView alloc] initWithFrame:CGRectMake(0, self.yhh_Height - 1, self.yhh_Width, 1)];
        [self addSubview:_shadow];
    }
    _shadow.backgroundColor = color;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_titleLabel) {
        [_titleLabel sizeToFit];
        _titleLabel.center = CGPointMake(self.yhh_Width / 2, centerY);
        [self addSubview:_titleLabel];
    }
    if (_titleView) {
        
    }
}
@end
