//
//  PlayerController.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "PlayerController.h"
#import <AVKit/AVKit.h>

#import "ONTPlayer.h"
#import "ONTPlayerControllBar.h"
#import "ONTPlayerActionBar.h"

@interface PlayerController () <ONTPlayerControllBarDeleage, ONTPlayerActionBarDeleage> {
    NSArray *layoutsForPortrait;
    NSArray *layoutsForLandScape;
    NSArray *baseViewLayouts;
    NSArray *playerPreviewLayouts;
}
@property (nonatomic, strong) ONTPlayer *player;
@property (nonatomic, strong) ONTPlayerControllBar *controllBar;
@property (nonatomic, strong) ONTPlayerActionBar *actionBar;

@property (nonatomic, strong) UIView *baseView;

@end

@implementation PlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addViews];
    [self layoutViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.controllBar startPlay];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)addViews {
    [self.view addSubview:self.baseView];
    [self.baseView addSubview:self.player.playerPreview];
    [self.baseView addSubview:self.controllBar];
    [self.view addSubview:self.actionBar];
}

- (void)layoutViews {
    self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
    self.player.playerPreview.translatesAutoresizingMaskIntoConstraints = NO;
    self.controllBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.actionBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    layoutsForPortrait = @[
                           [NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0],
                           [NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0],
                           [NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0],
                           [NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0.0],
                           
                           [NSLayoutConstraint constraintWithItem:self.actionBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0],
                           [NSLayoutConstraint constraintWithItem:self.actionBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0],
                           [NSLayoutConstraint constraintWithItem:self.actionBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-100.0],
                           [NSLayoutConstraint constraintWithItem:self.actionBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.0 constant:100.0],
                           ];
    
    layoutsForLandScape = @[
                            [NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0],
                            [NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0],
                            [NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0],
                            [NSLayoutConstraint constraintWithItem:self.baseView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0],
                            
                            [NSLayoutConstraint constraintWithItem:self.actionBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0],
                            [NSLayoutConstraint constraintWithItem:self.actionBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0],
                            [NSLayoutConstraint constraintWithItem:self.actionBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-44.0],
                            [NSLayoutConstraint constraintWithItem:self.actionBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.0 constant:44.0]
                            ];
    
    baseViewLayouts = @[
                        [NSLayoutConstraint constraintWithItem:self.controllBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0],
                        [NSLayoutConstraint constraintWithItem:self.controllBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0],
                        [NSLayoutConstraint constraintWithItem:self.controllBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0],
                        [NSLayoutConstraint constraintWithItem:self.controllBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]
                        ];
    
    playerPreviewLayouts = @[
                             [NSLayoutConstraint constraintWithItem:self.player.playerPreview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0],
                             [NSLayoutConstraint constraintWithItem:self.player.playerPreview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0],
                             [NSLayoutConstraint constraintWithItem:self.player.playerPreview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0],
                             [NSLayoutConstraint constraintWithItem:self.player.playerPreview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0],
                             ];
    
    
    [self.baseView addConstraints:baseViewLayouts];
    [self.baseView addConstraints:playerPreviewLayouts];
    NSInteger orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) {
        [self playerControllSwitchFullScreen:YES];
    } else {
//        if (orientation == UIDeviceOrientationPortrait) {
        [self playerControllSwitchFullScreen:NO];
    }
}

- (void)voiceButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - player action bar delegate
- (void)playerActionSaveScreenshotSuccess {
    [ONTTipCenter showSuccessTip:@"截图已保存到手机相册"];
}

- (void)playerActionSaveScreenshotError:(NSError *)error {
    [ONTTipCenter showFailTip:@"截图保存失败"];
}

#pragma mark - player controll bar delegate
- (void)playerControllReplay {
    //先做功能，后续优化
    if (self.player.isLocalVideo) {
        return;
    }
    [self.player shutdown];
    [self.player destroy];
    [self.player.playerPreview removeFromSuperview];
    [self.baseView removeConstraints:playerPreviewLayouts];
    _player = nil;
    self.controllBar.player = self.player;
    self.player.playerPreview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView addSubview:self.player.playerPreview];
    [self.baseView sendSubviewToBack:self.player.playerPreview];
    playerPreviewLayouts = @[
                             [NSLayoutConstraint constraintWithItem:self.player.playerPreview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0],
                             [NSLayoutConstraint constraintWithItem:self.player.playerPreview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0],
                             [NSLayoutConstraint constraintWithItem:self.player.playerPreview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0],
                             [NSLayoutConstraint constraintWithItem:self.player.playerPreview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.baseView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0],
                             ];
    
    [self.baseView addConstraints:playerPreviewLayouts];
}


- (void)playerControllSwitchFullScreen:(BOOL)isFullScreen {
    if (isFullScreen) {
        [self.view removeConstraints:layoutsForPortrait];
        [self.view addConstraints:layoutsForLandScape];
    } else {
        [self.view removeConstraints:layoutsForLandScape];
        [self.view addConstraints:layoutsForPortrait];
    }
    [self.view layoutIfNeeded];
    [self.actionBar switchFullScreen:isFullScreen];
}
- (void)playerControllLoadOverTime {
    [self.controllBar finishPlay];
    [self back];
}

- (void)playerControllExit {
    [self back];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
    }
    return _baseView;
}

- (ONTPlayer *)player {
    if (!_player) {
        _player = [[ONTPlayer alloc] initWithUrl:self.url];
        _player.playerType = _isLive ? ONTPlayerTypeLive: ONTPlayerTypeVod;
    }
    return _player;
}

- (ONTPlayerControllBar *)controllBar {
    if (!_controllBar) {
        _controllBar = [[ONTPlayerControllBar alloc] initWithPlayer:self.player];
        _controllBar.delegate = self;
    }
    return _controllBar;
}

- (ONTPlayerActionBar *)actionBar {
    if (!_actionBar) {
        _actionBar = [[ONTPlayerActionBar alloc] initWithPlayer:self.player];
        _actionBar.delegate = self;
    }
    return _actionBar;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
