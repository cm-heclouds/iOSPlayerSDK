//
//  LocalVideoController.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/26.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "LocalVideoController.h"
#import "PlaybackListCell.h"
#import <Photos/Photos.h>

#import "PlayerController.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface LocalVideoController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    PHPhotoLibrary *library;
    NSMutableArray *listArray;
}

@property (nonatomic, strong) UITableView *listView;

@end

@implementation LocalVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addViews];
    [self layoutViews];
    // Do any additional setup after loading the view.
}

- (void)getAssets {
    listArray = [NSMutableArray array];
    library = [PHPhotoLibrary sharedPhotoLibrary];
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:options];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self->listArray addObject:obj];
        if (*stop) {
            NSLog(@"stop");
        }

    }];
    [self.listView reloadData];

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
    [self getAssets];
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
    PHAsset *asset = listArray[indexPath.row];
    cell.duration = asset.duration;
    cell.title = [asset valueForKey:@"filename"];
    
    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    long long originFileSize = [[resource valueForKey:@"fileSize"] longLongValue];
    cell.fileSize = originFileSize;
    
    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        cell.videoImageView.image = [UIImage imageWithData:imageData];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = listArray[indexPath.row];
    [self getVideoFromPHAsset:asset];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void)getVideoFromPHAsset:(PHAsset *)asset {
    NSArray *assetResources = [PHAssetResource assetResourcesForAsset:asset];
    PHAssetResource *resource;
    for (PHAssetResource *assetRes in assetResources) {
        if (assetRes.type == PHAssetResourceTypePairedVideo || assetRes.type == PHAssetResourceTypeVideo) {
            resource = assetRes;
        }
        
    }
    NSString *fileName = @"tempVideo.mov";
    if (resource.originalFilename) {
        fileName = resource.originalFilename;
    }
    if (asset.mediaType == PHAssetMediaTypeVideo || asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
        NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] removeItemAtPath:tempPath error:nil];
        
        [[PHAssetResourceManager defaultManager] writeDataForAssetResource:resource toFile:[NSURL fileURLWithPath:tempPath] options:nil completionHandler:^(NSError * _Nullable error) {
            if (error) {

            } else {
                PlayerController *playerVc = [[PlayerController alloc] init];
//                playerVc.videoName = resource.originalFilename;
                playerVc.url = [NSURL fileURLWithPath:tempPath];
                playerVc.isLive = NO;
                [self.parentViewController.parentViewController.navigationController pushViewController:playerVc animated:YES];
            }
        }];
    } else {

    }
}
#pragma mark - getter
- (UITableView *)listView {
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_listView registerClass:[PlaybackListCell class] forCellReuseIdentifier:@"playbackListReuseId"];
        _listView.delegate = self;
        _listView.dataSource = self;
//
//        _listView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//            [self->listArray removeAllObjects];
//            self->pageIndex = 0;
//            [self.videoListApiManager loadData];
//        }];
//        _listView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
//            self->pageIndex++;
//            [self.videoListApiManager loadData];
//        }];
    }
    return _listView;
}

@end
