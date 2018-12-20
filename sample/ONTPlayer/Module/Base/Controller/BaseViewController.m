//
//  BaseViewController.m
//  ONTLive
//
//  Created by 汤世宇 on 2018/8/22.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *mainTitleLabel;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];

    [self addBaseViews];
    [self layoutBaseViews];
    // Do any additional setup after loading the view.
}

- (void)addBaseViews {
//    [self.view addSubview:self.backButton];
//    [self.view addSubview:self.mainTitleLabel];
    [self.view addSubview:self.contentView];
}

- (void)layoutBaseViews {
//    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(21);
//        make.left.equalTo(self.view);
//        make.width.height.mas_equalTo(42);
//    }];
//
//    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo (self.view).offset(20);
//        make.height.mas_equalTo(44);
//    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMainTitle:(NSString *)mainTitle {
    _mainTitle = mainTitle;
    self.mainTitleLabel.text = mainTitle;
}

- (void)popSelf {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:IMAGE(@"public_back") forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UILabel *)mainTitleLabel {
    if (!_mainTitleLabel) {
        _mainTitleLabel = [[UILabel alloc] init];
        _mainTitleLabel.font = FONT(18);
        _mainTitleLabel.textColor = RGBColor(51, 51, 51);
    }
    return _mainTitleLabel;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
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
