//
//  ONTPlayerControllerTopView.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/30.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ONTPlayerControllerTopView.h"

@implementation ONTPlayerControllerTopView
- (id)init {
    self = [super init];
    if (self) {
        [self setDradient];
        [self addViews];
        [self layoutViews];
    }
    return self;
}

- (void)setDradient {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = CGPointMake(0, 0);//（0，0）表示从左上角开始变化。默认值是(0.5,0.0)表示从x轴为中间，y为顶端的开始变化
    layer.endPoint = CGPointMake(0, 1);//（0，1）表示到右下角变化结束。默认值是(0.5,1.0)  表示从x轴为中间，y为低端的结束变化
    UIColor *topColor= [UIColor colorWithWhite:0 alpha:1.0];
    UIColor *bottomColor = [UIColor colorWithWhite:0 alpha:0.0];
    NSArray *colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
    layer.colors = colors;
    layer.frame = CGRectMake(0, 0, 1000, 44);
    [self.layer insertSublayer:layer atIndex:0];
}

- (void)addViews {
    [self addSubview:self.backButton];
    [self addSubview:self.titleLabel];
}

- (void)layoutViews {
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:44.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:44.0]];

    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:4.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"player_back"] forState:UIControlStateNormal];
        //        [_backButton setTitle:@"退出直播" forState:UIControlStateNormal];
        //        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _backButton.titleLabel.font = FONT(13);
    }
    return _backButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT(15);
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
