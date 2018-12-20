//
//  VodTokenAPIManager.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/29.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "CTAPIBaseManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface VodTokenAPIManager : CTAPIBaseManager <CTAPIManager, CTAPIManagerValidator>

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *videoId;

@property (nonatomic, strong) NSString *url;

@end

NS_ASSUME_NONNULL_END
