//
//  LoginController.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/17.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "LoginController.h"

#import "MediaController.h"

#import "LoginInputView.h"

@interface LoginController () <UITextFieldDelegate>

@property (nonatomic, strong) LoginInputView *deviceIdView;
@property (nonatomic, strong) LoginInputView *channelView;
@property (nonatomic, strong) LoginInputView *apiKeyView;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self layoutViews];
    [self textFieldDidChangedEditing:nil];
}


- (void)addViews {
    [self.view addSubview:self.deviceIdView];
    [self.view addSubview:self.channelView];
    [self.view addSubview:self.apiKeyView];
    [self.view addSubview:self.loginButton];
}

- (void)layoutViews {
    [self.deviceIdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.channelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deviceIdView.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];

    [self.apiKeyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelView.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];

    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.apiKeyView.mas_bottom).offset(60);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginButtonAction:(UIButton *)sender {
    [PlayerInfoManager shareManager].deviceId = self.deviceIdView.textField.text;
    [PlayerInfoManager shareManager].channelId = self.channelView.textField.text;
    [PlayerInfoManager shareManager].apiKey =  self.apiKeyView.textField.text;
    MediaController *vc = [[MediaController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidChangedEditing:(UITextField *)textField {
    if (self.deviceIdView.textField.text.length > 0 && self.channelView.textField.text.length > 0  && self.apiKeyView.textField.text.length > 0 ) {
        self.loginButton.enabled = YES;
    } else {
        self.loginButton.enabled = NO;
    }
}

- (LoginInputView *)deviceIdView {
    if (!_deviceIdView) {
        _deviceIdView = [[LoginInputView alloc] init];
        _deviceIdView.titleLabel.text = @"设备ID";
        _deviceIdView.textField.delegate = self;
        [_deviceIdView.textField addTarget:self action:@selector(textFieldDidChangedEditing:) forControlEvents:UIControlEventEditingChanged];
        _deviceIdView.textField.text = [PlayerInfoManager shareManager].deviceId;
    }
    return _deviceIdView;
}

- (LoginInputView *)channelView {
    if (!_channelView) {
        _channelView = [[LoginInputView alloc] init];
        _channelView.titleLabel.text = @"摄像头通道ID";
        _channelView.textField.delegate = self;
        [_channelView.textField addTarget:self action:@selector(textFieldDidChangedEditing:) forControlEvents:UIControlEventEditingChanged];
        _channelView.textField.text = [PlayerInfoManager shareManager].channelId;
    }
    return _channelView;
}

- (LoginInputView *)apiKeyView {
    if (!_apiKeyView) {
        _apiKeyView = [[LoginInputView alloc] init];
        _apiKeyView.titleLabel.text = @"APIKey";
        _apiKeyView.textField.delegate = self;
        [_apiKeyView.textField addTarget:self action:@selector(textFieldDidChangedEditing:) forControlEvents:UIControlEventEditingChanged];
        _apiKeyView.textField.text = [PlayerInfoManager shareManager].apiKey;
    }
    return _apiKeyView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"进入播放器" forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:RGBColor(198, 202, 206) size:CGSizeMake(SCREEN_WIDTH-32, 60)] forState:UIControlStateDisabled];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:RGBColor(27, 187, 255) size:CGSizeMake(SCREEN_WIDTH-32, 60)] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor colorWithWhite:0 alpha:0.3] forState:UIControlStateDisabled];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = FONT(14);
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.enabled = NO;

    }
    return _loginButton;
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
