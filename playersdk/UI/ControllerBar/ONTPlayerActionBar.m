//
//  ONTPlayerActionBar.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/11/2.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ONTPlayerActionBar.h"
#import <Photos/Photos.h>

@interface ONTPlayerActionBar () {
    NSArray *layoutsForPortrait;
    NSArray *layoutsForLandScape;
}

@property (nonatomic, strong) UIButton *screenshotButton;
@property (nonatomic, strong) UILabel *screenshotLabel;
@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) UILabel *voiceLabel;

@end

@implementation ONTPlayerActionBar

- (id)initWithPlayer:(ONTPlayer *)player {
    self = [super init];
    if (self) {
        _player = player;
        _playerType = player.playerType;
        [self addViews];
        [self layoutViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotated:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)addViews {
    if (_playerType == ONTPlayerTypeLive && [_player.url.absoluteString hasPrefix:@"rtmp"]) {
        [self addSubview:self.screenshotButton];
        [self addSubview:self.voiceButton];
        [self addSubview:self.screenshotLabel];
        [self addSubview:self.voiceLabel];
        
        self.screenshotButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.screenshotLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.voiceButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.voiceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    } else {
        [self addSubview:self.screenshotButton];
        [self addSubview:self.screenshotLabel];
        self.screenshotButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.screenshotLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

- (void)layoutViews {
    if (_playerType == ONTPlayerTypeLive && [_player.url.absoluteString hasPrefix:@"rtmp"]) {
        layoutsForPortrait = @[
                               [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-60.0],
                               [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:74.0],
                               [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:74.0],
                               
                               [NSLayoutConstraint constraintWithItem:self.screenshotLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.screenshotButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:4.0],
                               [NSLayoutConstraint constraintWithItem:self.screenshotLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.screenshotButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],

                               [NSLayoutConstraint constraintWithItem:self.voiceButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self.voiceButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:60.0],
                               [NSLayoutConstraint constraintWithItem:self.voiceButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:74.0],
                               [NSLayoutConstraint constraintWithItem:self.voiceButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:74.0],
                               
                               [NSLayoutConstraint constraintWithItem:self.voiceLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.voiceButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:4.0],
                               [NSLayoutConstraint constraintWithItem:self.voiceLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.voiceButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],
                               ];
        
        layoutsForLandScape = @[
                                [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-30.0],
                                [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:37.0],
                                [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:37.0],
                                
                                [NSLayoutConstraint constraintWithItem:self.voiceButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:30.0],
                                [NSLayoutConstraint constraintWithItem:self.voiceButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.voiceButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:37.0],
                                [NSLayoutConstraint constraintWithItem:self.voiceButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:37.0],
                                ];
    } else {
        layoutsForPortrait = @[
                               [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:00.0],
                               [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:74.0],
                               [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:74.0],
                               
                               [NSLayoutConstraint constraintWithItem:self.screenshotLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.screenshotButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:4.0],
                               [NSLayoutConstraint constraintWithItem:self.screenshotLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.screenshotButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],
                               ];
        
        layoutsForLandScape = @[
                                [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:37.0],
                                [NSLayoutConstraint constraintWithItem:self.screenshotButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:37.0],
                                ];

    }

    [self deviceDidRotated:nil];
}

- (void)switchFullScreen:(BOOL)isFullScreen {
    if (isFullScreen) {
        [self switchViewsForLandscape];
    } else {
        [self switchViewsForPortrait];
    }
}

- (void)switchViewsForLandscape {
    [self removeConstraints:layoutsForPortrait];
    [self addConstraints:layoutsForLandScape];
    [self layoutIfNeeded];
    if (_playerType == ONTPlayerTypeLive && [_player.url.absoluteString hasPrefix:@"rtmp"]) {
        self.screenshotLabel.hidden = YES;
        self.voiceLabel.hidden = YES;
    } else {
        self.screenshotLabel.hidden = YES;
    }
}

- (void)switchViewsForPortrait {
    [self removeConstraints:layoutsForLandScape];
    [self addConstraints:layoutsForPortrait];
    [self layoutIfNeeded];
    if (_playerType == ONTPlayerTypeLive && [_player.url.absoluteString hasPrefix:@"rtmp"]) {
        self.screenshotLabel.hidden = NO;
        self.voiceLabel.hidden = NO;
    } else {
        self.screenshotLabel.hidden = NO;
    }
}

#pragma mark - screenshot
- (void)saveCurrentScreenshot {
    UIImage *screenShot = _player.screenshot;
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        [ONTTipCenter showFailTip:@"没有权限访问相册"];
    } else {
        UIImageWriteToSavedPhotosAlbum(screenShot, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
        if ([_delegate respondsToSelector:@selector(playerActionSaveScreenshotSuccess)]) {
            [_delegate playerActionSaveScreenshotSuccess];
        }
    } else {
        if ([_delegate respondsToSelector:@selector(playerActionSaveScreenshotError:)]) {
            [_delegate playerActionSaveScreenshotError:error];
        }
    }
}

- (void)deviceDidRotated:(NSNotification *)notification {
    NSInteger orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) {
        [self switchViewsForLandscape];
    } else if (orientation == UIDeviceOrientationPortrait) {
        [self switchViewsForPortrait];
    }
}

- (void)screenShotButtonAction:(UIButton *)sender {
    [self saveCurrentScreenshot];
}

- (void)voiceButtonAction:(UIButton *)sender {
    if (!self.player.isPlaying) {
        [ONTTipCenter showFailTip:@"直播还未开始，无法打开语音"];
        return;
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.player startPushingAudio];
    } else {
        [self.player stopPushingAudio];
    }
}

#pragma mark - setter & getter

- (UIButton *)screenshotButton {
    if (!_screenshotButton) {
        _screenshotButton = [[UIButton alloc] init];
        [_screenshotButton setBackgroundImage:[UIImage imageNamed:@"player_screenshot"] forState:UIControlStateNormal];
        [_screenshotButton addTarget:self action:@selector(screenShotButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _screenshotButton;
}

- (UILabel *)screenshotLabel {
    if (!_screenshotLabel) {
        _screenshotLabel = [[UILabel alloc] init];
        _screenshotLabel.text = @"视频截图";
        _screenshotLabel.textColor = [UIColor colorWithRed:57/255.0 green:62/255.0 blue:76/255.0 alpha:1];
        _screenshotLabel.font = [UIFont systemFontOfSize:12];
    }
    return _screenshotLabel;
}

- (UIButton *)voiceButton {
    if (!_voiceButton) {
        _voiceButton = [[UIButton alloc] init];
        [_voiceButton setBackgroundImage:[UIImage imageNamed:@"player_voice_off"] forState:UIControlStateNormal];
        [_voiceButton setBackgroundImage:[UIImage imageNamed:@"player_voice_on"] forState:UIControlStateSelected];
        [_voiceButton addTarget:self action:@selector(voiceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (UILabel *)voiceLabel {
    if (!_voiceLabel) {
        _voiceLabel = [[UILabel alloc] init];
        _voiceLabel.text = @"打开麦克风";
        _voiceLabel.textColor = [UIColor colorWithRed:57/255.0 green:62/255.0 blue:76/255.0 alpha:1];
        _voiceLabel.font = [UIFont systemFontOfSize:12];
    }
    return _voiceLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
