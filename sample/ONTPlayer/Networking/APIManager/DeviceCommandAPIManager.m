//
//  DeviceCommandAPIManager.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/11.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "DeviceCommandAPIManager.h"
#import "ONTPlayerValidator.h"

@implementation DeviceCommandAPIManager
- (id)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)methodName {
    return [NSString stringWithFormat: @"cmds?device_id=%@&qos=1&type=0",  [PlayerInfoManager shareManager].deviceId];
//    return @"cmds";
}

- (NSString *)serviceIdentifier {
    return @"ONTPlayerService";
}

- (CTAPIManagerRequestType)requestType {
    return CTAPIManagerRequestTypePost;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return CTAPIManagerErrorTypeNoError;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    return [ONTPlayerValidator validateForManager:manager isCorrectWithCallBackData:data];
}
@end
