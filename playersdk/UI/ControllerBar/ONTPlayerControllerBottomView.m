//
//  ONTPlayerControllerBottomView.m
//  
//
//  Created by 汤世宇 on 2018/10/30.
//

#import "ONTPlayerControllerBottomView.h"

@implementation ONTPlayerControllerBottomView

- (id)initWithType:(ONTPlayerType)type {
    self = [super init];
    if (self) {
        [self setDradient];
        if (type == ONTPlayerTypeLive) {
            [self addLiveViews];
            [self layoutLiveViews];
            self.timeLabel.hidden = YES;
        } else {
            [self addVodViews];
            [self layoutVodViews];
        }
    }
    return self;
}

- (void)setDradient {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = CGPointMake(0, 0);//（0，0）表示从左上角开始变化。默认值是(0.5,0.0)表示从x轴为中间，y为顶端的开始变化
    layer.endPoint = CGPointMake(0, 1);//（0，1）表示到右下角变化结束。默认值是(0.5,1.0)  表示从x轴为中间，y为低端的结束变化
    UIColor *topColor= [UIColor colorWithWhite:0 alpha:0.0];
    UIColor *bottomColor = [UIColor colorWithWhite:0 alpha:1.0];
    NSArray *colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
    layer.colors = colors;
    layer.frame = CGRectMake(0, 0, 1000, 44);
    [self.layer insertSublayer:layer atIndex:0];
}

- (void)addPublicViews {
    [self addSubview:self.playButton];
    [self addSubview:self.fullScreenButton];
    [self addSubview:self.timeLabel];
}

- (void)layoutPublicViews {
    self.playButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:4.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:44.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:44.0]];
    
    self.fullScreenButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fullScreenButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fullScreenButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-4.0]];;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fullScreenButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:44.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fullScreenButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:44.0]];
    
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.playButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.playButton attribute:NSLayoutAttributeWidth multiplier:0.0 constant:60.0]];
}

- (void)addLiveViews {
    [self addPublicViews];
    [self addSubview:self.refreshButton];
}

- (void)layoutLiveViews {
    [self layoutPublicViews];
    self.refreshButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.refreshButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.refreshButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.playButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:8.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.refreshButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:44.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.refreshButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:44.0]];
}

- (void)addVodViews {
    [self addPublicViews];
    [self addSubview:self.totalLabel];
    [self addSubview:self.slider];
}

- (void)layoutVodViews {
    [self layoutPublicViews];
    
    self.totalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.totalLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.totalLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.fullScreenButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.totalLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:60.0]];
    
    self.slider.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.totalLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-8.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:8.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:44.0]];
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        [_playButton setImage:[UIImage imageNamed:@"player_stop"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateSelected];
    }
    return _playButton;
}

- (UIButton *)fullScreenButton {
    if (!_fullScreenButton) {
        _fullScreenButton = [[UIButton alloc] init];
        [_fullScreenButton setImage:[UIImage imageNamed:@"player_full_screen"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:(@"player_normal_screen")] forState:UIControlStateSelected];
    }
    return _fullScreenButton;
}

- (UIButton *)refreshButton {
    if (!_refreshButton) {
        _refreshButton = [[UIButton alloc] init];
    }
    return _refreshButton;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] init];
        [_slider setThumbImage:[UIImage imageNamed:@"player_slider"] forState:UIControlStateNormal];
        [_slider setTintColor:RGBColor(27, 187, 255)];
    }
    return _slider;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = @"00:00:00";
    }
    return _timeLabel;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.font = [UIFont systemFontOfSize:12];
        _totalLabel.textColor = [UIColor whiteColor];
        _totalLabel.textAlignment = NSTextAlignmentCenter;
        _totalLabel.text = @"00:00:00";
    }
    return _totalLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
