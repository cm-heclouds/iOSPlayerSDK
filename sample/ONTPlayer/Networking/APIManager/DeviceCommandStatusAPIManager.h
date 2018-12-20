//
//  DeviceCommandStatusAPIManager.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/12.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "CTAPIBaseManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeviceCommandStatusAPIManager : CTAPIBaseManager <CTAPIManager, CTAPIManagerValidator>

@property (nonatomic, strong) NSString *uuid;

@end

NS_ASSUME_NONNULL_END
