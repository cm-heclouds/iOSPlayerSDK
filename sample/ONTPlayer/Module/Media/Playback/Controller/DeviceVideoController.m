//
//  DeviceVideoController.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/26.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "DeviceVideoController.h"

#import "PlaybackListCell.h"
#import "DeviceCommandAPIManager.h"
#import "DeviceCommandRespAPIManager.h"
#import "DeviceCommandStatusAPIManager.h"
#import "LiveAddressAPIManager.h"

#import "PlayerController.h"

@interface DeviceVideoController () <UITableViewDelegate, UITableViewDataSource, CTAPIManagerParamSource, CTAPIManagerCallBackDelegate> {
    int pageIndex;
    NSMutableArray *listArray;
}

@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) DeviceCommandAPIManager *commandApiManager;
@property (nonatomic, strong) DeviceCommandStatusAPIManager *statusApiManager;
@property (nonatomic, strong) DeviceCommandRespAPIManager *respApiManager;
@property (nonatomic, strong) LiveAddressAPIManager *addressApiManager;

@end

@implementation DeviceVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addViews];
    [self layoutViews];
//    [self setData];
    // Do any additional setup after loading the view.
}

- (void)addViews {
    [self.view addSubview:self.listView];
}

- (void)layoutViews {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
}

- (void)loadData {
    if (listArray.count > 0) {
        return;
    }
    listArray = [NSMutableArray array];
    pageIndex = 1;
    [self.commandApiManager loadData];
    [SVProgressHUD show];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return 20;
    return listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *videoInfo = listArray[indexPath.row];
    PlaybackListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playbackListReuseId" forIndexPath:indexPath];
    cell.videoTitleLabel.text = videoInfo[@"video_title"];
    cell.fileSize = [videoInfo[@"size"] longLongValue];
    cell.videoLengthLabel.text = [NSString stringWithFormat: @"%@-%@", videoInfo[@"beginTime"], videoInfo[@"endTime"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *videoInfo = listArray[indexPath.row];
    self.addressApiManager.channelId = videoInfo[@"channel_id"];
    self.addressApiManager.beginTime = videoInfo[@"beginTime"];
    self.addressApiManager.endTime = videoInfo[@"endTime"];
    [self.addressApiManager loadData];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - api delegate & paramsSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    NSDictionary *params = @{};
    if ([manager isKindOfClass:[DeviceCommandAPIManager class]]) {
        params = @{@"cmd": @{@"channel_id": @([[PlayerInfoManager shareManager].channelId intValue]), @"page": [NSNumber numberWithInt:pageIndex], @"per_page": @(10)},
                   @"cmdId": @(10),
                   @"type": @"video"
                   };
    } else if ([manager isKindOfClass:[DeviceCommandStatusAPIManager class]]) {
        params = @{@"device_id": [PlayerInfoManager shareManager].deviceId,
                   @"cmd_uuid": self.statusApiManager.uuid
                   };
    } else if ([manager isKindOfClass:[DeviceCommandRespAPIManager class]]) {
        params = @{@"device_id": [PlayerInfoManager shareManager].deviceId,
                   @"cmd_uuid": self.respApiManager.uuid
                   };
    } else if ([manager isKindOfClass:[LiveAddressAPIManager class]]) {
        params = @{@"device_id": [PlayerInfoManager shareManager].deviceId,
//                   @"channel_id": self.addressApiManager.channelId,
                   @"channel_id": [PlayerInfoManager shareManager].channelId,
                   @"protocol_type":@"0"
                   };
    }
    return params;
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
//    [self.listView.mj_header endRefreshing];
//    [self.listView.mj_footer endRefreshing];
    [SVProgressHUD dismiss];

    [ONTTipCenter showFailTip:manager.errorMessage.length < 1 ? manager.errorMsg : manager.errorMessage];
    NSLog(@"%@", manager.errorMessage.length < 1 ? manager.errorMsg : manager.errorMessage);
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
//    [self.listView.mj_header endRefreshing];
//    [self.listView.mj_footer endRefreshing];
    if (manager == self.commandApiManager) {
        NSDictionary *result = [manager fetchDataWithReformer:nil];
        int err = [result[@"errno"] intValue];
        if (err == 0) {
            int status = [result[@"data"][@"cmd_status"] intValue];
            if (status == 4) {
                self.respApiManager.uuid = result[@"data"][@"cmd_uuid"];
                [self.respApiManager loadData];
            } else {
                self.statusApiManager.uuid = result[@"data"][@"cmd_uuid"];
                [self.statusApiManager loadData];
            }
        }
    } else if (manager == self.statusApiManager) {
        NSDictionary *result = [manager fetchDataWithReformer:nil];
        int err = [result[@"errno"] intValue];
        if (err == 0) {
            int status = [result[@"data"][@"status"] intValue];
            if (status == 4) {
                self.respApiManager.uuid = self.statusApiManager.uuid;
                [self.respApiManager loadData];
            } else if (status == 2) {
                NSLog(@"status - %d", status);
                [self.statusApiManager loadData];
            } else {
                [SVProgressHUD dismiss];
                NSString *tip;
                if (status == 0) {
                    tip = @"device not online";
                } else if (status == 3) {
                    tip = @"send error";
                } else if (status == 5) {
                    tip = @"time out";
                } else if (status == 6) {
                    tip = @"resp data error";
                }
                NSLog(@"command status - %d", status);
            }
        }
    } else if (manager == self.respApiManager) {
        NSString *result = [manager fetchDataWithReformer:nil][@"resp"];
        NSData *data = [[NSData alloc] initWithBase64EncodedString:result options:NSDataBase64DecodingIgnoreUnknownCharacters];
        NSDictionary *dictFromData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        listArray = dictFromData[@"rvods"];
        [self.listView reloadData];
        [SVProgressHUD dismiss];
    } else if (manager == self.addressApiManager) {
        NSDictionary *result = [manager fetchDataWithReformer:nil][@"data"];
        [self playWithInfo:result];
    }
}

- (void)playWithInfo:(NSDictionary *)videoInfo {
    NSString *begin = [self timeStringFromString:self.addressApiManager.beginTime];
    NSString *end = [self timeStringFromString:self.addressApiManager.endTime];
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/rvod/%@-%@-%@-%@?%@", videoInfo[@"type"], videoInfo[@"addr"], [PlayerInfoManager shareManager].deviceId, [PlayerInfoManager shareManager].channelId, begin, end, videoInfo[@"accessToken"]];
    
    PlayerController *playerVc = [[PlayerController alloc] init];
    playerVc.url = [NSURL URLWithString:urlString];
//    playerVc.videoName = @"设备视频";
    playerVc.isLive = NO;
    [self.navigationController pushViewController:playerVc animated:YES];
}

- (NSString *)timeStringFromString:(NSString *)string {
    NSString *result;
    result = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@":" withString:@""];
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (UITableView *)listView {
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_listView registerClass:[PlaybackListCell class] forCellReuseIdentifier:@"playbackListReuseId"];
        _listView.delegate = self;
        _listView.dataSource = self;
        
//        _listView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//            [self->listArray removeAllObjects];
//            self->pageIndex = 0;
//            [self.commandApiManager loadData];
//        }];
//        _listView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
//            self->pageIndex++;
//            [self.commandApiManager loadData];
//        }];
    }
    return _listView;
}

- (DeviceCommandAPIManager *)commandApiManager {
    if (!_commandApiManager) {
        _commandApiManager = [[DeviceCommandAPIManager alloc] init];
        _commandApiManager.delegate = self;
        _commandApiManager.paramSource = self;
    }
    return _commandApiManager;
}

- (DeviceCommandRespAPIManager *)respApiManager {
    if (!_respApiManager) {
        _respApiManager = [[DeviceCommandRespAPIManager alloc] init];
        _respApiManager.delegate = self;
        _respApiManager.paramSource = self;
    }
    return _respApiManager;
}

- (DeviceCommandStatusAPIManager *)statusApiManager {
    if (!_statusApiManager) {
        _statusApiManager = [[DeviceCommandStatusAPIManager alloc] init];
        _statusApiManager.delegate = self;
        _statusApiManager.paramSource = self;
    }
    return _statusApiManager;
}

- (LiveAddressAPIManager *)addressApiManager {
    if (!_addressApiManager) {
        _addressApiManager = [[LiveAddressAPIManager alloc] init];
        _addressApiManager.delegate = self;
        _addressApiManager.paramSource = self;
    }
    return _addressApiManager;
}


@end
