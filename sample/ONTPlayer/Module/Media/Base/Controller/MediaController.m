//
//  MediaController.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "MediaController.h"

#import "MediaTypeView.h"
#import "LiveController.h"
#import "PlaybackController.h"

@interface MediaController ()

@property (nonatomic, strong) MediaTypeView *typeView;
@property (nonatomic, strong) UIButton *exitButton;
@property (nonatomic, strong) UIView *separator;

@property (nonatomic, strong) LiveController *liveController;
@property (nonatomic, strong) PlaybackController *playbackController;

@end

@implementation MediaController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self layoutViews];
    [self addControllers];
    // Do any additional setup after loading the view.
}

- (void)addViews {
    [self.contentView addSubview:self.typeView];
    [self.contentView addSubview:self.exitButton];
    [self.contentView addSubview:self.separator];
    
    [self.contentView addSubview:self.liveController.view];
    [self.contentView addSubview:self.playbackController.view];
}

- (void)layoutViews {
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(4);
        make.left.equalTo(self.contentView).offset(16);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(80);
    }];
    
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-4);
        make.height.width.mas_equalTo(44);
    }];
    
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.typeView.mas_bottom).offset(12);
        make.height.mas_equalTo(LINE_WIDTH);
    }];
    
    [self.liveController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.separator).offset(1);
    }];
    
    [self.playbackController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.separator).offset(1);
    }];
}

- (void)addControllers {
    [self addChildViewController:self.liveController];
    [self addChildViewController:self.playbackController];
}

- (void)exitButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectTypeAction:(UIButton *)sender {
    if (self.playbackController.view.hidden) {
        self.playbackController.view.hidden = NO;
        self.typeView.typeLabel.text = @"点播回放";
        [self.playbackController loadData];
    } else {
        self.playbackController.view.hidden = YES;
        self.typeView.typeLabel.text = @"视频直播";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MediaTypeView *)typeView {
    if (!_typeView) {
        _typeView = [[MediaTypeView alloc] init];
        [_typeView.typeButton addTarget:self action:@selector(selectTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _typeView;
}

- (UIButton *)exitButton {
    if (!_exitButton) {
        _exitButton = [[UIButton alloc] init];
        [_exitButton setImage:IMAGE(@"media_exit") forState:UIControlStateNormal];
        [_exitButton addTarget:self action:@selector(exitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitButton;
}

- (UIView *)separator {
    if (!_separator) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
    }
    return _separator;
}

- (LiveController *)liveController {
    if (!_liveController) {
        _liveController = [[LiveController alloc] init];
    }
    return _liveController;
}

- (PlaybackController *)playbackController {
    if (!_playbackController) {
        _playbackController = [[PlaybackController alloc] init];
        _playbackController.view.hidden = YES;

    }
    return _playbackController;
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
