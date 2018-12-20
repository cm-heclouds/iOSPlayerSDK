//
//  DeviceVideoListAPIManager.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/25.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ServerVideoListAPIManager.h"
#import "ONTPlayerValidator.h"

@implementation ServerVideoListAPIManager
- (id)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)methodName {
    return @"vod/get_video_list";
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
