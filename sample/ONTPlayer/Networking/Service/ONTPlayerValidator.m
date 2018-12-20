//
//  ONTPlayerValidator.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/20.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ONTPlayerValidator.h"

@implementation ONTPlayerValidator

+ (CTAPIManagerErrorType)validateForManager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    if (data.count == 0) {
        manager.errorMsg = @"网络错误";
        return CTAPIManagerErrorTypeNoNetWork;
    }
    
    int code = [data[@"errno"] intValue];
    if (code == 0) {
        return CTAPIManagerErrorTypeNoError;
    } else {
        manager.errorMsg = data[@"error"];
        manager.errorCode = code;
        return CTAPIManagerErrorTypeDefault;
    }
}

@end
