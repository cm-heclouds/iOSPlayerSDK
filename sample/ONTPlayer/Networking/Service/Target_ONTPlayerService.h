//
//  Target_ONTPlayerService.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/20.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ONTPlayerService.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const CTONTPlayerServiceIdentifier;

@interface Target_ONTPlayerService : NSObject

- (ONTPlayerService *)Action_ONTPlayerService:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
