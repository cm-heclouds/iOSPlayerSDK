//
//  ONTFrame.h
//  ONTLive
//
//  Created by 汤世宇 on 2018/8/23.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONTFrame : NSObject

@property (nonatomic, assign) uint64_t timestamp;
@property (nonatomic, strong) NSData *data;
///< flv或者rtmp包头
@property (nonatomic, strong) NSData *header;

@end
