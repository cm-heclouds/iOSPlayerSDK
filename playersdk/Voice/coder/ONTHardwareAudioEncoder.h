//
//  ONTHardwareAudioEncoder.h
//  ONTLive
//
//  Created by 汤世宇 on 2018/8/23.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ONTAudioEncoding.h"

@interface ONTHardwareAudioEncoder : NSObject <ONTAudioEncoding>

#pragma mark - Initializer
///=============================================================================
/// @name Initializer
///=============================================================================
- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (nullable instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
