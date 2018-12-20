//
//  NoWifiTipView.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/10.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ONTPlayerTipView.h"

#define ONTPLAYERDEFAULTWIDTH [UIScreen mainScreen].bounds.size.width

@interface ONTPlayerTipView () {
    NSArray *constraintsArray;
    UIView *superView;
}

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIImageView *playIcon;


@end


@implementation ONTPlayerTipView

- (id)initWithTitle:(NSString *)title message:(NSString *)message tag:(int)tag delegate:(id<ONTPlayerTipViewDelegate>)delegate {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addViews];
        [self layoutViews];
        self.titleLabel.text = title;
        self.tipLabel.text = message;
        self.tag = tag;
        self.delegate = delegate;
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addViews];
        [self layoutViews];
    }
    return self;
}

- (void)showInView:(UIView *)view {
    superView = view;
    constraintsArray = @[[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0],
                         [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0],
                         [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0],
                         [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]
                        
                        ];
    [superView addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addConstraints:constraintsArray];
}

- (void)hide {
    [self removeFromSuperview];
    [superView removeConstraints:constraintsArray];
    superView = nil;
    constraintsArray = nil;
}

- (void)addViews {
    [self addSubview:self.baseView];
    [self addSubview:self.tipLabel];
    [self.baseView addSubview:self.actionButton];
    [self.baseView addSubview:self.playIcon];
    [self.baseView addSubview:self.titleLabel];
}

- (void)layoutViews {
    self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-16.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:120.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:32.0]];

    self.playIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView addConstraint:[NSLayoutConstraint constraintWithItem:self.playIcon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.baseView addConstraint:[NSLayoutConstraint constraintWithItem:self.playIcon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.0]];
    [self.baseView addConstraint:[NSLayoutConstraint constraintWithItem:self.playIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:11.0]];
    [self.baseView addConstraint:[NSLayoutConstraint constraintWithItem:self.playIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:12.0]];

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.baseView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.0]];
    
    self.actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self.baseView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self.baseView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self.baseView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    self.tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-44.0]];
}

- (void)buttonAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(tipViewAction:)]) {
        [_delegate tipViewAction:self];
    }
    [self hide];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
//        _contentLabel.text = @"继续播放";
        _titleLabel.textColor = RGBColor(27, 187, 255);
        _titleLabel.font = FONT(15);
    }
    return _titleLabel;
}

- (UIImageView *)playIcon {
    if (!_playIcon) {
        _playIcon = [[UIImageView alloc] init];
        _playIcon.image = [UIImage imageNamed:@"player_tip_play"];
    }
    return _playIcon;
}

- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = RGBColor(29, 31, 39);
        _baseView.layer.cornerRadius = 16;
    }
    return _baseView;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [[UIButton alloc] init];
        [_actionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"您正在使用移动网络，继续播放将消耗流量";
        _tipLabel.textColor = RGBAColor(255, 255, 255, 0.7);
        _tipLabel.font = FONT(14);
    }
    return _tipLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
