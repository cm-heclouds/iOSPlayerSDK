//
//  ONTPlayerControllerBar.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ONTPlayerControllBar.h"
#import "ONTPlayerTipView.h"
#import "ONTPlayerNetManager.h"

#import "ONTPlayerControllerTopView.h"
#import "ONTPlayerControllerBottomView.h"

@interface ONTPlayerControllBar () <ONTPlayerDelegate, ONTPlayerTipViewDelegate> {
    NSTimer *progressTimer;
    NSTimer *OTTimer;
    int currentNetStatus;
}

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) ONTPlayerControllerTopView *topView;
@property (nonatomic, strong) ONTPlayerControllerBottomView *bottomView;

@end

@implementation ONTPlayerControllBar

- (id)initWithPlayer:(ONTPlayer *)player {
    self = [super init];
    if (self) {
        _player = player;
        _player.playerDelegate = self;
        _playerType = _player.playerType;
        [self addViews];
        [self layoutViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotated:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)startPlay {
    if (_playerType == ONTPlayerTypeVod) {
        if (_player.isLocalVideo) {
            [self start];
        } else {
            currentNetStatus = [ONTPlayerNetManager internetStatus];
            if (currentNetStatus == 2) {
                [self showNotWifiTip];
            } else if (currentNetStatus == 1)  {
                [self start];
            } else {
                NSLog(@"没有网络");
            }
        }
    } else {
        currentNetStatus = [ONTPlayerNetManager internetStatus];
        if (currentNetStatus == 2) {
            [self showNotWifiTip];
        } else if (currentNetStatus == 1)  {
            [self start];
        } else {
            NSLog(@"没有网络");
        }
    }
}

- (void)finishPlay {
    [self setNewOrientation:NO];
    if (progressTimer) {
        [progressTimer invalidate];
        progressTimer = nil;
    }
    
    if (OTTimer) {
        [OTTimer invalidate];
        OTTimer = nil;
    }
    [_player finishPlay];
}

- (void)start {
    [self showLoadingHud];
    [_player play];
}

- (void)startTimer {
    if (!progressTimer) {
        progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(playingProgressDidChanged) userInfo:nil repeats:YES];
    } else {
        [progressTimer setFireDate:[NSDate date]];
    }
}

- (void)continuePlay {
    [_player continuePlay];
}

- (void)pause {
    [_player pause];
    if (_playerType == ONTPlayerTypeVod) {
        [progressTimer setFireDate: [NSDate distantFuture]];
    }
}

- (void)replay {
    [_player replay];
}

- (void)end {
    if (_playerType == ONTPlayerTypeVod) {
        [progressTimer invalidate];
        progressTimer = nil;
        self.bottomView.playButton.selected = YES;
        self.bottomView.slider.value = 0;
        self.bottomView.timeLabel.text = @"00:00";
    }
}

#pragma mark - tips & loadings
- (void)showNotWifiTip {
    ONTPlayerTipView *tip = [[ONTPlayerTipView alloc] initWithTitle:@"继续播放" message:@"您正在使用移动网络，继续播放将消耗流量" tag:1000 delegate:self];
    [tip showInView:self];
}

- (void)tipViewAction:(UIView *)tipView {
    if (tipView.tag == 1000) {
        [self start];
    } else if (tipView.tag == 1001) {
        if ([_delegate respondsToSelector:@selector(playerControllExit)]) {
            [_delegate playerControllExit];
        }
    } else {
        if ([_delegate respondsToSelector:@selector(playerControllLoadOverTime)]) {
            [_delegate playerControllLoadOverTime];
        }
    }
}

- (void)showLoadingHud {
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;
}

- (void)hideLoadingHud {
    [self.indicatorView stopAnimating];
    self.indicatorView.hidden = YES;
}

#pragma mark - player delegate
- (void)loadStatusChanged:(ONTPlayerLoadStatus)loadStatus {
    if (loadStatus == ONTPlayerLoadStatusOK) {
        NSLog(@"load status ok");
        [self hideLoadingHud];
        [self loadStatusOK];
    } else if (loadStatus == ONTPlayerLoadStatusStalled) {
        NSLog(@"load status Stalled");
        [self showLoadingHud];
        [self loadStatusDidStalled];
    }
}

- (void)loadStatusOK {
    if (_player.isLocalVideo) {
        return;
    }
    [OTTimer invalidate];
    OTTimer = nil;
}

- (void)loadStatusDidStalled {
    if (_player.isLocalVideo) {
        return;
    }
    __block int overtime = 0;
    OTTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        overtime++;
        int net = [ONTPlayerNetManager internetStatus];
        if (net > 0) {
            [self->_player play];
        } else {
            ONTPlayerTipView *tip = [[ONTPlayerTipView alloc] initWithTitle:@"退出播放" message:@"网络连接失败，请稍后重试" tag:1003 delegate:self];
            [tip showInView:self];
        }
//        if (overtime > 20) {
//            [self finishPlay];
//            ONTPlayerTipView *tip = [[ONTPlayerTipView alloc] initWithTitle:@"退出播放" message:@"加载失败，请稍后重试" tag:1001 delegate:self];
//            [tip showInView:self];
//        }
    }];
}

- (void)playStatusChanged:(ONTPlayerPlayStatus)playStatus {
    if (playStatus == ONTPlayerPlayStatusStopped) {
        [self end];
    } else if (playStatus == ONTPlayerPlayStatusStart) {
        self.bottomView.totalLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)_player.duration / 3600, (int)_player.duration % 3600 / 60, (int)_player.duration % 60];
        [self startTimer];
    } else if (playStatus == ONTPlayerPlayStatusError) {
        ONTPlayerTipView *tip = [[ONTPlayerTipView alloc] initWithTitle:@"退出播放" message:@"加载失败，请稍后重试" tag:1002 delegate:self];
        [tip showInView:self];
    } else if (playStatus == ONTPlayerPlayStatusEnded) {

    }
}

- (void)playingProgressDidChanged {
    if (_playerType == ONTPlayerTypeVod) {
        self.bottomView.slider.value = _player.currentPlaybackTime / _player.duration;
        int hour = (int)floor(_player.currentPlaybackTime) / 3600;
        int mimute = (int)floor(_player.currentPlaybackTime) % 3600 / 60;
        int second = (int)floor(_player.currentPlaybackTime) % 60;
        self.bottomView.timeLabel.text = [NSString stringWithFormat: @"%02d:%02d:%02d", hour, mimute, second];
    } else {
        int hour = (int)floor(_player.currentPlaybackTime) / 3600;
        int mimute = (int)floor(_player.currentPlaybackTime) % 3600 / 60;
        int second = (int)_player.currentPlaybackTime % 60;
        self.bottomView.timeLabel.text = [NSString stringWithFormat: @"%02d:%02d:%02d",hour, mimute, second];
    }
}

#pragma mark - views & layouts
- (void)addViews {
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self addSubview:self.indicatorView];
}

- (void)layoutViews {
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:44.0]];;
    
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:44.0]];;
    
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];;
}

#pragma mark - actions
- (void)playButtonAction:(UIButton *)sender {
    if (_player.playStatus == ONTPlayerPlayStatusStart) {
        [self pause];
        sender.selected = YES;
    } else if (_player.playStatus == ONTPlayerPlayStatusPaused) {
        [self continuePlay];
        sender.selected = NO;
    } else if (_player.playStatus == ONTPlayerPlayStatusEnded || _player.playStatus == ONTPlayerPlayStatusStopped) {
        if ([_delegate respondsToSelector:@selector(playerControllReplay)]) {
            [_delegate playerControllReplay];
        }
        [self replay];
        sender.selected = NO;
    }
}

- (void)fullScreenButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self setNewOrientation:sender.selected];
}

- (void)sliderValueChanged:(UISlider *)sender {
    NSTimeInterval seekTime = sender.value * _player.duration;
    [_player seekTo:seekTime];
    if ([_delegate respondsToSelector:@selector(playerControllSeekToTime:)]) {
        [_delegate playerControllSeekToTime:seekTime];
    }
}

- (void)backButtonAction:(UIButton *)sender {
    [self finishPlay];
    if ([_delegate respondsToSelector:@selector(playerControllExit)]) {
        [_delegate playerControllExit];
    }
}

- (void)deviceDidRotated:(NSNotification *)notification {
    NSInteger orientation = [UIDevice currentDevice].orientation;
    NSLog(@"orientation -- %ld", orientation);
    if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) {
        self.bottomView.fullScreenButton.selected = YES;
        if ([_delegate respondsToSelector:@selector(playerControllSwitchFullScreen:)]) {
            [_delegate playerControllSwitchFullScreen:YES];
        }
    } else if (orientation == UIDeviceOrientationPortrait) {
        self.bottomView.fullScreenButton.selected = NO;
        if ([_delegate respondsToSelector:@selector(playerControllSwitchFullScreen:)]) {
            [_delegate playerControllSwitchFullScreen:NO];
        }
    }
    
//    UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
//    UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
//    UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
//    UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
//    UIDeviceOrientationFaceUp,              // Device oriented flat, face up
//    UIDeviceOrientationFaceDown             // Device oriented flat, face down
}

- (void)setNewOrientation:(BOOL)fullscreen {
    if ([_delegate respondsToSelector:@selector(playerControllSwitchFullScreen:)]) {
        [_delegate playerControllSwitchFullScreen:fullscreen];
    }
    if (fullscreen) {
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    } else {
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - setter and getter
- (void)setPlayer:(ONTPlayer *)player {
    _player = player;
    _playerType = player.playerType;
    _player.playerDelegate = self;
}

- (ONTPlayerControllerTopView *)topView {
    if (!_topView) {
        _topView = [[ONTPlayerControllerTopView alloc] init];
        [_topView.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topView;
}

- (ONTPlayerControllerBottomView *)bottomView {
    if (!_bottomView) {
        if (_playerType == ONTPlayerTypeLive) {
            _bottomView = [[ONTPlayerControllerBottomView alloc] initWithType:ONTPlayerTypeLive];
        } else {
            _bottomView = [[ONTPlayerControllerBottomView alloc] initWithType:ONTPlayerTypeVod];
            [_bottomView.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        }
        [_bottomView.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.fullScreenButton addTarget:self action:@selector(fullScreenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger orientation = [UIDevice currentDevice].orientation;
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) {
            _bottomView.fullScreenButton.selected = YES;
        }
    }
    return _bottomView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _indicatorView;
}

@end
