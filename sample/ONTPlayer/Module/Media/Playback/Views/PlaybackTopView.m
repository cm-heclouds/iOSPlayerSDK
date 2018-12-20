//
//  PlaybackTopView.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "PlaybackTopView.h"

@interface PlaybackTopView ()

@property (nonatomic, strong) UIButton *deviceButton;
@property (nonatomic, strong) UIButton *localButton;
@property (nonatomic, strong) UIButton *serverButton;
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) UIView *separator;

@end

@implementation PlaybackTopView

- (id)init {
    self = [super init];
    if (self) {
        [self addViews];
        [self layoutViews];
    }
    return self;
}

- (void)addViews {
    [self addSubview:self.deviceButton];
    [self addSubview:self.localButton];
    [self addSubview:self.serverButton];
    [self addSubview:self.sliderView];
    [self addSubview:self.separator];
}

- (void)layoutViews {
    [self.deviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).multipliedBy(1/3.0);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-3);
    }];
    
    [self.localButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-3);
    }];
    
    [self.serverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).multipliedBy(5/3.0);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-3);
    }];
    
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(LINE_WIDTH);
    }];
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-LINE_WIDTH);
        make.centerX.equalTo(self.deviceButton);
        make.width.equalTo(self.deviceButton).multipliedBy(0.6);
        make.height.mas_equalTo(2);
    }];
}

- (void)selectTypeAction:(UIButton *)sender {
    self.deviceButton.selected = NO;
    self.localButton.selected = NO;
    self.serverButton.selected = NO;
    sender.selected = YES;

    [self.sliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-LINE_WIDTH);
        make.centerX.equalTo(sender);
        make.width.equalTo(sender).multipliedBy(0.6);
        make.height.mas_equalTo(2);
    }];
    [UIView animateWithDuration:0.15 animations:^{
        [self layoutIfNeeded];
    }];
    
    _selectedIndex = (int)sender.tag - 1000;
    if ([_delegate respondsToSelector:@selector(topViewDidSelectedIndex:)]) {
        [_delegate topViewDidSelectedIndex:(int)sender.tag - 1000];
    }
}

- (void)setSelectedIndex:(int)selectedIndex {
    _selectedIndex = selectedIndex;
    self.deviceButton.selected = NO;
    self.localButton.selected = NO;
    self.serverButton.selected = NO;
    UIButton *button = [self viewWithTag:1000 + selectedIndex];
    [button sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)deviceButton {
    if (!_deviceButton) {
        _deviceButton = [[UIButton alloc] init];
        [_deviceButton setTitle:@"设备视频" forState:UIControlStateNormal];
        _deviceButton.titleLabel.font = FONT(15);
        [_deviceButton setTitleColor:RGBColor(57, 62, 76) forState:UIControlStateNormal];
        [_deviceButton setTitleColor:RGBColor(27, 187, 255) forState:UIControlStateSelected];
        [_deviceButton addTarget:self action:@selector(selectTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        _deviceButton.selected = YES;
        _deviceButton.tag = 1000;
    }
    return _deviceButton;
}

- (UIButton *)localButton {
    if (!_localButton) {
        _localButton = [[UIButton alloc] init];
        [_localButton setTitle:@"本地视频" forState:UIControlStateNormal];
        _localButton.titleLabel.font = FONT(15);
        [_localButton setTitleColor:RGBColor(57, 62, 76) forState:UIControlStateNormal];
        [_localButton setTitleColor:RGBColor(27, 187, 255) forState:UIControlStateSelected];
        [_localButton addTarget:self action:@selector(selectTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        _localButton.tag = 1001;
    }
    return _localButton;
}

- (UIButton *)serverButton {
    if (!_serverButton) {
        _serverButton = [[UIButton alloc] init];
        [_serverButton setTitle:@"服务器视频" forState:UIControlStateNormal];
        _serverButton.titleLabel.font = FONT(15);
        [_serverButton setTitleColor:RGBColor(57, 62, 76) forState:UIControlStateNormal];
        [_serverButton setTitleColor:RGBColor(27, 187, 255) forState:UIControlStateSelected];
        [_serverButton addTarget:self action:@selector(selectTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        _serverButton.tag = 1002;
    }
    return _serverButton;
}

- (UIView *)sliderView  {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
        _sliderView.backgroundColor = RGBColor(27, 187, 255);
    }
    return _sliderView;
}

- (UIView *)separator {
    if (!_separator) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
    }
    return _separator;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
