//
//  LiveAddressAPIManager.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/20.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "CTAPIBaseManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveAddressAPIManager : CTAPIBaseManager <CTAPIManager, CTAPIManagerValidator>

@property (nonatomic, strong) NSString *protocolType;

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSNumber *channelId;
@property (nonatomic, strong) NSString *beginTime;
@property (nonatomic, strong) NSString *endTime;

@end

NS_ASSUME_NONNULL_END
