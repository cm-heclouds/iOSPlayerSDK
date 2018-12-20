//
//  ONTPlayerValidator.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/20.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CTNetworking/CTNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface ONTPlayerValidator : NSObject

+ (CTAPIManagerErrorType)validateForManager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
