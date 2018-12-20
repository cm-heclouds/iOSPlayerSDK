//
//  ONTPlayerVoiceSession.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/11/15.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ONTPlayerVoiceSession.h"

#import "ONTAudioCapture.h"
#import "ONTLiveAudioConfiguration.h"
#import "ONTHardwareAudioEncoder.h"

#define NOW (CACurrentMediaTime()*1000)

@interface ONTPlayerVoiceSession () <ONTAudioCaptureDelegate, ONTAudioEncodingDelegate> {
    BOOL startPush;
    BOOL isEnd;
}

@property (nonatomic, strong) ONTAudioCapture *audioCaptureSource;
@property (nonatomic, strong) ONTHardwareAudioEncoder *audioEncoder;
@property (nonatomic, strong) ONTLiveAudioConfiguration *audioConfiguration;

/// 上传相对时间戳
@property (nonatomic, assign) uint64_t relativeTimestamps;
/// 时间戳锁
@property (nonatomic, strong) dispatch_semaphore_t lock;

@end

@implementation ONTPlayerVoiceSession

- (void)startVoiceConnection {
    self.audioCaptureSource.running = YES;
    _isVoiceConnected = YES;
}

- (void)stopVoiceConnection {
    self.audioCaptureSource.running = NO;
    _isVoiceConnected = NO;
}

- (void)audioEncoder:(id<ONTAudioEncoding>)encoder audioFrame:(ONTAudioFrame *)frame {

    [self pushSendBuffer:frame];
}


- (void)captureOutput:(ONTAudioCapture *)capture audioData:(NSData *)audioData {
    [self.audioEncoder encodeAudioData:audioData timeStamp:NOW];
}

- (void)pushSendBuffer:(ONTFrame*)frame {
    if (self.relativeTimestamps == 0){
        self.relativeTimestamps = frame.timestamp;
    }
    
    frame.timestamp = [self uploadTimestamp:frame.timestamp];
    [self sendFrame:frame];
}

- (void)sendFrame:(ONTFrame *)frame {
    if ([_sessionDelegate respondsToSelector:@selector(voiceSessionNeedPushData:timestamp:)]) {
        [_sessionDelegate voiceSessionNeedPushData:frame.data timestamp:frame.timestamp];
    }
//    [_player pushAudioData:frame.data timestamp:frame.timestamp];
}

- (uint64_t)uploadTimestamp:(uint64_t)captureTimestamp{
    dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
    uint64_t currentts = 0;
    currentts = captureTimestamp - self.relativeTimestamps;
    dispatch_semaphore_signal(self.lock);
    return currentts;
}

- (ONTAudioCapture *)audioCaptureSource {
    if (!_audioCaptureSource) {
        _audioConfiguration = [ONTLiveAudioConfiguration defaultConfiguration];
        _audioCaptureSource = [[ONTAudioCapture alloc] initWithAudioConfiguration:_audioConfiguration];
        _audioCaptureSource.delegate = self;
        _audioCaptureSource.muted = NO;
    }
    return _audioCaptureSource;
}

- (id<ONTAudioEncoding>)audioEncoder {
    if (!_audioEncoder) {
        _audioEncoder = [[ONTHardwareAudioEncoder alloc] initWithAudioStreamConfiguration:_audioConfiguration];
        [_audioEncoder setDelegate:self];
    }
    return _audioEncoder;
}

- (dispatch_semaphore_t)lock {
    if(!_lock){
        _lock = dispatch_semaphore_create(1);
    }
    return _lock;
}

@end
