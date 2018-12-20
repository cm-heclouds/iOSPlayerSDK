//
//  ONTLiveAudioConfiguration.h
//  ONTLive
//
//  Created by 汤世宇 on 2018/8/23.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 音频码率 (默认96Kbps)
typedef NS_ENUM (NSUInteger, ONTLiveAudioBitRate) {
    /// 32Kbps 音频码率
    ONTLiveAudioBitRate_32Kbps = 32000,
    /// 64Kbps 音频码率
    ONTLiveAudioBitRate_64Kbps = 64000,
    /// 96Kbps 音频码率
    ONTLiveAudioBitRate_96Kbps = 96000,
    /// 128Kbps 音频码率
    ONTLiveAudioBitRate_128Kbps = 128000,
    /// 默认音频码率，默认为 96Kbps
    ONTLiveAudioBitRate_Default = ONTLiveAudioBitRate_96Kbps
};

/// 音频采样率 (默认44.1KHz)
typedef NS_ENUM (NSUInteger, ONTLiveAudioSampleRate){
    /// 16KHz 采样率
    ONTLiveAudioSampleRate_16000Hz = 16000,
    /// 44.1KHz 采样率
    ONTLiveAudioSampleRate_44100Hz = 44100,
    /// 48KHz 采样率
    ONTLiveAudioSampleRate_48000Hz = 48000,
    /// 默认音频采样率，默认为 44.1KHz
    ONTLiveAudioSampleRate_Default = ONTLiveAudioSampleRate_44100Hz
};

///  Audio Live quality（音频质量）
typedef NS_ENUM (NSUInteger, ONTLiveAudioQuality){
    /// 低音频质量 audio sample rate: 16KHz audio bitrate: numberOfChannels 1 : 32Kbps  2 : 64Kbps
    ONTLiveAudioQuality_Low = 0,
    /// 中音频质量 audio sample rate: 44.1KHz audio bitrate: 96Kbps
    ONTLiveAudioQuality_Medium = 1,
    /// 高音频质量 audio sample rate: 44.1MHz audio bitrate: 128Kbps
    ONTLiveAudioQuality_High = 2,
    /// 超高音频质量 audio sample rate: 48KHz, audio bitrate: 128Kbps
    ONTLiveAudioQuality_VeryHigh = 3,
    /// 默认音频质量 audio sample rate: 44.1KHz, audio bitrate: 96Kbps
    ONTLiveAudioQuality_Default = ONTLiveAudioQuality_High
};


@interface ONTLiveAudioConfiguration : NSObject<NSCoding, NSCopying>

/// 默认音频配置
+ (instancetype)defaultConfiguration;
/// 音频配置
+ (instancetype)defaultConfigurationForQuality:(ONTLiveAudioQuality)audioQuality;

#pragma mark - Attribute
///=============================================================================
/// @name Attribute
///=============================================================================
/// 声道数目(default 2)
@property (nonatomic, assign) NSUInteger numberOfChannels;
/// 采样率
@property (nonatomic, assign) ONTLiveAudioSampleRate audioSampleRate;
/// 码率
@property (nonatomic, assign) ONTLiveAudioBitRate audioBitrate;
/// flv编码音频头 44100 为0x12 0x10
@property (nonatomic, assign, readonly) char *asc;
/// 缓存区长度
@property (nonatomic, assign,readonly) NSUInteger bufferLength;

@end
