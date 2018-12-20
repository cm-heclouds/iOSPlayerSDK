//
//  ServerVideoController.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/26.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ServerVideoController.h"

#import "PlaybackListCell.h"
#import "ServerVideoListAPIManager.h"
#import "VodTokenAPIManager.h"

#import "PlayerController.h"

@interface ServerVideoController () <UITableViewDelegate, UITableViewDataSource, CTAPIManagerParamSource, CTAPIManagerCallBackDelegate> {
    int pageIndex;
    NSMutableArray *listArray;
}

@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) ServerVideoListAPIManager *videoListApiManager;
@property (nonatomic, strong) VodTokenAPIManager *tokenApiManager;

@end

@implementation ServerVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addViews];
    [self layoutViews];
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
    [self.videoListApiManager loadData];
//    [SVProgressHUD show];
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaybackListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playbackListReuseId" forIndexPath:indexPath];
    NSDictionary *videoInfo = listArray[indexPath.row];
    cell.videoTitleLabel.text = videoInfo[@"name"];
    cell.fileSize = [videoInfo[@"size"] longLongValue];
    cell.videoLengthLabel.text = [NSString stringWithFormat: @"%@-%@", videoInfo[@"start_time"], videoInfo[@"end_time"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *videoInfo = listArray[indexPath.row];
    self.tokenApiManager.deviceId = [PlayerInfoManager shareManager].deviceId;
    self.tokenApiManager.channelId = [PlayerInfoManager shareManager].channelId;
    self.tokenApiManager.videoId = videoInfo[@"videoid"];
    self.tokenApiManager.url = videoInfo[@"hls_url"];
    [self.tokenApiManager loadData];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - api delegate & paramsSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    NSDictionary *params;
    if (manager == self.videoListApiManager) {
        params = @{@"device_id": [PlayerInfoManager shareManager].deviceId,
                   @"channel_id": [PlayerInfoManager shareManager].channelId,
                   @"page_start": [NSString stringWithFormat:@"%d", pageIndex],
                   @"page_size": @"20"
                   };
    } else {
        params = @{@"device_id": self.tokenApiManager.deviceId,
                   @"channel_id": self.tokenApiManager.channelId,
                   @"video_id": self.tokenApiManager.videoId
                   };
    }
    return params;
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
//    [self.listView.mj_header endRefreshing];
//    [self.listView.mj_footer endRefreshing];
//    [SVProgressHUD dismiss];
    [ONTTipCenter showFailTip:manager.errorMessage.length < 1 ? manager.errorMsg : manager.errorMessage];
    NSLog(@"%@", manager.errorMessage.length < 1 ? manager.errorMsg : manager.errorMessage);
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
//    [self.listView.mj_header endRefreshing];
//    [self.listView.mj_footer endRefreshing];
    if (manager == self.videoListApiManager) {
        NSArray *result = [manager fetchDataWithReformer:nil][@"data"];
        if (result.count > 0) {
            [listArray addObjectsFromArray:result];
            [self.listView reloadData];
        }
//        [SVProgressHUD dismiss];
    } else {
        NSDictionary *result = [manager fetchDataWithReformer:nil][@"data"];
        NSString *token = result[@"token"];
        NSString *urlString = [NSString stringWithFormat:@"%@?token=%@", self.tokenApiManager.url, token];
        
        PlayerController *playerVc = [[PlayerController alloc] init];
        playerVc.url = [NSURL URLWithString:urlString];
        [self.navigationController pushViewController:playerVc animated:YES];
    }

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
//            self->pageIndex = 1;
//            [self.videoListApiManager loadData];
//        }];
//        _listView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
//            self->pageIndex++;
//            [self.videoListApiManager loadData];
//        }];
    }
    return _listView;
}

- (ServerVideoListAPIManager *)videoListApiManager {
    if (!_videoListApiManager) {
        _videoListApiManager = [[ServerVideoListAPIManager alloc] init];
        _videoListApiManager.delegate = self;
        _videoListApiManager.paramSource = self;
    }
    return _videoListApiManager;
}

- (VodTokenAPIManager *)tokenApiManager {
    if (!_tokenApiManager) {
        _tokenApiManager = [[VodTokenAPIManager alloc] init];
        _tokenApiManager.delegate = self;
        _tokenApiManager.paramSource = self;
    }
    return _tokenApiManager;
}

@end
