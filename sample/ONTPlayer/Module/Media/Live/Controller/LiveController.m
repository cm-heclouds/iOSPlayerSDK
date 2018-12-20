//
//  LiveController.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "LiveController.h"
#import "LiveHeaderView.h"
#import "LiveSelectionCell.h"
#import "LiveUrlCell.h"

#import "LiveAddressAPIManager.h"

#import "PlayerController.h"

@interface LiveController () <UITableViewDelegate, UITableViewDataSource, CTAPIManagerCallBackDelegate, CTAPIManagerParamSource>

@property (nonatomic, strong) UITableView *baseView;
@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) LiveAddressAPIManager *addressApiManager;

@end

@implementation LiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addViews];
    [self layoutViews];
    // Do any additional setup after loading the view.
}

- (void)addViews {
    [self.view addSubview:self.baseView];
    [self.view addSubview:self.playButton];
}

- (void)layoutViews {
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-16);
        make.bottom.equalTo(self.view).offset(-40);
        make.height.mas_equalTo(50);
        make.left.equalTo(self.view).offset(16);
    }];
}

- (void)playButtonAction:(UIButton *)sender {
    LiveSelectionCell *resolutionCell = [self.baseView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    LiveUrlCell *urlCell = [self.baseView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (urlCell.url.length < 1) {
        [ONTTipCenter showFailTip:@"请先获取直播地址"];
        return;
    }
    
    PlayerController *playerVc = [[PlayerController alloc] init];
    playerVc.url = [NSURL URLWithString:urlCell.url];
//    playerVc.videoName = @"视频直播";
    playerVc.isLive = YES;
    [self.navigationController pushViewController:playerVc animated:YES];
}

- (void)getUrlButtonAction:(UIButton *)sender {
    LiveSelectionCell *protocolCell = [self.baseView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    self.addressApiManager.protocolType = [NSString stringWithFormat:@"%ld", (long)protocolCell.selectedIndex];
    [self.addressApiManager loadData];
}

#pragma mark - api delegate & paramsSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    NSDictionary *params = @{@"device_id": [PlayerInfoManager shareManager].deviceId,
                             @"channel_id": [PlayerInfoManager shareManager].channelId,
                             @"protocol_type":self.addressApiManager.protocolType
                             };
    return params;
    
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    [ONTTipCenter showFailTip:manager.errorMessage.length < 1 ? manager.errorMsg : manager.errorMessage];
    NSLog(@"%@", manager.errorMessage.length < 1 ? manager.errorMsg : manager.errorMessage);
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    NSDictionary *result = [manager fetchDataWithReformer:nil][@"data"];
    NSString *urlString;
    NSString *type = result[@"type"];
    if ([type isEqualToString:@"rtmp"] || [type isEqualToString:@"rtmpe"]) {
        urlString = [NSString stringWithFormat:@"%@://%@/live/%@-%@?%@", result[@"type"], result[@"addr"], [PlayerInfoManager shareManager].deviceId, [PlayerInfoManager shareManager].channelId, result[@"accessToken"]];
    } else {
        urlString = [NSString stringWithFormat:@"%@://%@/live/live_%@_%@/index.m3u8?%@", result[@"type"], result[@"addr"], [PlayerInfoManager shareManager].deviceId, [PlayerInfoManager shareManager].channelId, result[@"accessToken"]];
    }
    NSLog(@"%@", urlString);
    LiveUrlCell *cell = [self.baseView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.url = urlString;
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LiveHeaderView *headerView = [[LiveHeaderView alloc] init];
    headerView.titleLabel.text = @[@"播放协议", @"获取直播地址", @"清晰度选择"][section];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        LiveUrlCell *cell = [[LiveUrlCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        [cell.getUrlButton addTarget:self action:@selector(getUrlButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        LiveSelectionCell *cell = [[LiveSelectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        cell.titleArray = @[@[@"RTMP", @"HLS", @"HTTPS-HLS"], @[], @[@"超清", @"高清", @"标清"]][indexPath.section];
        return cell;
    }
}

#pragma mark - getter
- (UITableView *)baseView {
    if (!_baseView) {
        _baseView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _baseView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _baseView.backgroundColor = [UIColor  whiteColor];
        _baseView.delegate = self;
        _baseView.dataSource = self;
        _baseView.bounces = NO;
    }
    return _baseView;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        [_playButton setBackgroundImage:[UIImage imageWithColor:RGBColor(27, 187, 255) size:CGSizeMake(SCREEN_WIDTH-32, 60)] forState:UIControlStateNormal];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _playButton.titleLabel.font = FONT(14);
        [_playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (LiveAddressAPIManager *)addressApiManager {
    if (!_addressApiManager) {
        _addressApiManager = [[LiveAddressAPIManager alloc] init];
        _addressApiManager.delegate = self;
        _addressApiManager.paramSource = self;
    }
    return _addressApiManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
