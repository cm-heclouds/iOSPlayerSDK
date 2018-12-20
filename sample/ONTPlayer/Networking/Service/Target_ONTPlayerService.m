//
//  Target_ONTPlayerService.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/20.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "Target_ONTPlayerService.h"

NSString * const CTONTPlayerServiceIdentifier = @"ONTPlayerService";

@implementation Target_ONTPlayerService

- (ONTPlayerService *)Action_ONTPlayerService:(NSDictionary *)params {
    return [[ONTPlayerService alloc] init];
}

@end
