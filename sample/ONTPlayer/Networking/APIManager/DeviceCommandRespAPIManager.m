//
//  DeviceCommandRespAPIManager.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/11.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "DeviceCommandRespAPIManager.h"
#import "ONTPlayerValidator.h"

@implementation DeviceCommandRespAPIManager
- (id)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)methodName {
//    return [NSString stringWithFormat: @"cmd_resp?device_id=%@&cmd_uuid=%@",  [PlayerInfoManager shareManager].deviceId, _uuid];
        return @"cmd_resp";
}

- (NSString *)serviceIdentifier {
    return @"ONTPlayerService";
}

- (CTAPIManagerRequestType)requestType {
    return CTAPIManagerRequestTypeGet;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return CTAPIManagerErrorTypeNoError;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    return [ONTPlayerValidator validateForManager:manager isCorrectWithCallBackData:data];
}
@end
