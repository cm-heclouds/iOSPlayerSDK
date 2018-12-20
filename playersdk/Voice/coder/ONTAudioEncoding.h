//
//  ONTAudioEncoding.h
//  ONTLive
//
//  Created by 汤世宇 on 2018/8/23.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ONTAudioFrame.h"
#import "ONTLiveAudioConfiguration.h"


@protocol ONTAudioEncoding;
/// 编码器编码后回调
@protocol ONTAudioEncodingDelegate <NSObject>
@required
- (void)audioEncoder:(nullable id<ONTAudioEncoding>)encoder audioFrame:(nullable ONTAudioFrame *)frame;
@end

/// 编码器抽象的接口
@protocol ONTAudioEncoding <NSObject>
@required
- (void)encodeAudioData:(nullable NSData*)audioData timeStamp:(uint64_t)timeStamp;
- (void)stopEncoder;
@optional
- (nullable instancetype)initWithAudioStreamConfiguration:(nullable ONTLiveAudioConfiguration *)configuration;
- (void)setDelegate:(nullable id<ONTAudioEncodingDelegate>)delegate;
- (nullable NSData *)adtsData:(NSInteger)channel rawDataLength:(NSInteger)rawDataLength;
@end

