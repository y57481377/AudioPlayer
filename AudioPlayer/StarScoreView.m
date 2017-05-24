//
//  StarScoreView.m
//  AudioPlayer
//
//  Created by Yang on 2017/5/23.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "StarScoreView.h"

@implementation StarScoreView {
    CAShapeLayer *_starsLayer;
    CAGradientLayer *_gradientLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    CGFloat radio = 10;
    UIBezierPath *path = [self starWithradio:radio];
    _starsLayer = [CAShapeLayer layer];
    _starsLayer.path = path.CGPath;
    
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = CGRectMake(0, 0, 10 * radio, 2 * radio);
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(1,0);
    _gradientLayer.colors = [NSArray arrayWithObjects:(id)yhh_Color(252, 170, 44, 1).CGColor, (id)yhh_Color(211, 211, 211, 1).CGColor,nil];
    _gradientLayer.mask = _starsLayer;
    [self.layer addSublayer:_gradientLayer];

}

- (void)setScore:(CGFloat)score {
    _score = score;
    
    if (!_maxScore)
        _maxScore = 10.0;
    
    CGFloat rat = score/_maxScore;
    _gradientLayer.locations = @[@(rat),@(0),@(1-rat)];
}

- (void)setStarSize:(CGSize)starSize {
    _starSize = starSize;
    
    CGFloat radio = MIN(_starSize.height, _starSize.width) * 0.5;
    UIBezierPath *path = [self starWithradio:radio];
    _starsLayer.path = path.CGPath;
    _gradientLayer.frame = CGRectMake(0, 0, 10 * radio, 2 * radio);
}

// 画五角星
- (UIBezierPath *)starWithradio:(CGFloat)radio {
    CGFloat x = radio;
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < 5; i++) {
        CGPoint start = CGPointMake(x, 0);
        
        CGFloat m1 = sinf(M_PI*0.4) * radio;
        CGFloat n1 = cosf(M_PI*0.4) * radio;
        
        CGPoint left1 = CGPointMake(start.x - m1, start.y + radio - n1);
        ;
        CGPoint right1 = CGPointMake(start.x + m1, start.y + radio - n1);
        
        CGFloat m2 = sinf(M_PI * 0.2) * radio;
        CGFloat n2 = cosf(M_PI * 0.2) * radio;
        
        CGPoint left2 = CGPointMake(start.x - m2, start.y + radio + n2);
        CGPoint right2 = CGPointMake(start.x + m2, start.y + radio + n2);
        
        CGPoint A = [self intersectionU1:start u2:left2 v1:left1 v2:right1];
        CGPoint B = [self intersectionU1:start u2:left2 v1:left1 v2:right2];
        CGPoint C = [self intersectionU1:left1 u2:right2 v1:left2 v2:right1];
        CGPoint D = CGPointMake(2 * start.x - B.x, B.y);
        CGPoint E = CGPointMake(2 * start.x - A.x, A.y);
        
        
        [path moveToPoint:start];
        [path addLineToPoint:A];
        [path addLineToPoint:left1];
        [path addLineToPoint:B];
        [path addLineToPoint:left2];
        [path addLineToPoint:C];
        [path addLineToPoint:right2];
        [path addLineToPoint:D];
        [path addLineToPoint:right1];
        [path addLineToPoint:E];
        [path closePath];
        
        x += 2*radio;
    }
    return path;
}

#pragma mark ------------ 判断两条直线是否相交
- (BOOL)checkLineIntersection:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 p4:(CGPoint)p4
{
    CGFloat denominator = (p4.y - p3.y) * (p2.x - p1.x) - (p4.x - p3.x) * (p2.y - p1.y);
    
    if (denominator == 0.0f) {
        
        return NO;
    }
    
    CGFloat ua = ((p4.x - p3.x) * (p1.y - p3.y) - (p4.y - p3.y) * (p1.x - p3.x))/denominator;
    CGFloat ub = ((p2.x - p1.x) * (p1.y - p3.y) - (p2.y - p1.y) * (p1.x - p3.x))/denominator;
    
    if (ua >= 0.0f && ua <= 1.0f && ub >= 0.0f && ub <= 1.0f) {
        
        return YES;
    }
    
    return NO;
}

#pragma mark ------------ 两条直线要是相交 求出相交点
- (CGPoint)intersectionU1:(CGPoint)u1 u2:(CGPoint)u2 v1:(CGPoint)v1 v2:(CGPoint)v2
{
    CGPoint ret = u1;
    
    double t = ((u1.x - v1.x) * (v1.y - v2.y) - (u1.y - v1.y) * (v1.x - v2.x))/((u1.x-u2.x) * (v1.y - v2.y) - (u1.y - u2.y) * (v1.x - v2.x));
    
    ret.x += (u2.x - u1.x) * t;
    ret.y += (u2.y - u1.y) * t;
    
    return ret;
}
@end
