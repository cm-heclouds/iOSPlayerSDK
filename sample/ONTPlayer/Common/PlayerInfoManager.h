//
//  PlayerInfoManager.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/19.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerInfoManager : NSObject

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *apiKey;

+ (PlayerInfoManager *)shareManager;

@end
