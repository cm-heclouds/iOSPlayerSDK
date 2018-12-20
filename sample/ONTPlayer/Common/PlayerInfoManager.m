//
//  PlayerInfoManager.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/19.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "PlayerInfoManager.h"

static PlayerInfoManager *_liveInfo;
@implementation PlayerInfoManager

+ (PlayerInfoManager *)shareManager {
    @synchronized (self) {
        if (_liveInfo == nil) {
            _liveInfo = [[self alloc] init];
        }
    }
    return _liveInfo;
}

- (NSString *)deviceId {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"];
    }
    return @"";
}

- (NSString *)channelId {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"channelId"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"channelId"];
    }
    return @"";
}

- (NSString *)apiKey {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
    }
    return @"";
}

- (void)setDeviceId:(NSString *)deviceId {
    [[NSUserDefaults standardUserDefaults] setObject:deviceId forKey:@"deviceId"];
}

- (void)setChannelId:(NSString *)channelId {
    [[NSUserDefaults standardUserDefaults] setObject:channelId forKey:@"channelId"];
}

- (void)setApiKey:(NSString *)apiKey {
    [[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:@"apiKey"];
}

@end
