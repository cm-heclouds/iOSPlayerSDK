//
//  PlaybackController.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "PlaybackController.h"

#import "PlaybackTopView.h"

#import "DeviceVideoController.h"
#import "LocalVideoController.h"
#import "ServerVideoController.h"

@interface PlaybackController () <UIScrollViewDelegate, PlaybackTopViewDelegate>

@property (nonatomic, strong) PlaybackTopView *topView;
@property (nonatomic, strong) UIScrollView *baseView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) DeviceVideoController *deviceController;
@property (nonatomic, strong) LocalVideoController *localController;
@property (nonatomic, strong) ServerVideoController *serverController;

@end

@implementation PlaybackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addControllers];
    [self addViews];
    [self layoutViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotated:) name:UIDeviceOrientationDidChangeNotification object:nil];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.baseView.contentOffset = CGPointMake(self.topView.selectedIndex * SCREEN_WIDTH, 0);
}

- (void)deviceDidRotated:(NSNotification *)notification {
    self.baseView.contentOffset = CGPointMake(self.topView.selectedIndex * SCREEN_WIDTH, 0);
}

- (void)addViews {
    [self.view addSubview:self.topView];
    [self.view addSubview:self.baseView];
    [self.baseView addSubview:self.contentView];
    [self.baseView addSubview:self.deviceController.view];
    [self.baseView addSubview:self.localController.view];
    [self.baseView addSubview:self.serverController.view];
}

- (void)layoutViews {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.baseView);
        make.width.height.equalTo(self.baseView);
    }];
    
    [self.deviceController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.width.equalTo(self.contentView);
    }];

    [self.localController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.deviceController.view.mas_right);
        make.top.bottom.width.equalTo(self.contentView);
    }];

    [self.serverController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.localController.view.mas_right);
        make.top.bottom.width.equalTo(self.contentView);
    }];
}

- (void)addControllers {
    [self addChildViewController:self.deviceController];
    [self addChildViewController:self.localController];
    [self addChildViewController:self.serverController];
}

- (void)loadData {
    [self.deviceController loadData];
    [self.localController loadData];
    [self.serverController loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.baseView) {
        self.topView.selectedIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    }
}

#pragma mark - topView delegate
- (void)topViewDidSelectedIndex:(int)selectedIndex {
    [self.baseView setContentOffset:CGPointMake(SCREEN_WIDTH * selectedIndex, 0) animated:YES];
}

#pragma mark - getter
- (PlaybackTopView *)topView {
    if (!_topView) {
        _topView = [[PlaybackTopView alloc] init];
        _topView.delegate = self;
    }
    return _topView;
}

- (UIScrollView *)baseView {
    if (!_baseView) {
        _baseView = [[UIScrollView alloc] init];
        _baseView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT - 117);
        _baseView.pagingEnabled = YES;
        _baseView.showsVerticalScrollIndicator = NO;
        _baseView.showsHorizontalScrollIndicator = NO;
//        _baseView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        _baseView.delegate = self;
        _baseView.bounces = NO;
        _baseView.backgroundColor = [UIColor redColor];
    }
    return _baseView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (DeviceVideoController *)deviceController {
    if (!_deviceController) {
        _deviceController = [[DeviceVideoController alloc] init];
    }
    return _deviceController;
}

- (LocalVideoController *)localController {
    if (!_localController) {
        _localController = [[LocalVideoController alloc] init];
    }
    return _localController;
}

- (ServerVideoController *)serverController {
    if (!_serverController) {
        _serverController = [[ServerVideoController alloc] init];
    }
    return _serverController;
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
