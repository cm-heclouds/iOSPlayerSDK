//
//  LiveAddressAPIManager.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/20.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "LiveAddressAPIManager.h"
#import "ONTPlayerValidator.h"

@implementation LiveAddressAPIManager
- (id)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)methodName {
    return @"play_address";
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
