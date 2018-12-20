//
//  ONTPlayer.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ONTPlayerConst.h"
#import "ONTPlayerVoiceSession.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ONTPlayerDelegate <NSObject>

- (void)loadStatusChanged:(ONTPlayerLoadStatus)loadStatus;
- (void)playStatusChanged:(ONTPlayerPlayStatus)playStatus;

@end


@interface ONTPlayer : NSObject <ONTPlayerVoiceSessionDelegate>

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) UIView *playerPreview;
@property (nonatomic, readonly) UIImage *screenshot;

@property (nonatomic) BOOL shouldAutoPlay;
@property (nonatomic) int retryCount;

@property (nonatomic, readonly) BOOL isLocalVideo;
@property (nonatomic) ONTPlayerType playerType;

@property (nonatomic, readonly) CGFloat videoSize;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic, readonly) NSTimeInterval currentPlaybackTime;

@property (nonatomic) BOOL isPlaying;
@property (nonatomic) ONTPlayerPlayStatus playStatus;

@property (nonatomic, weak) id<ONTPlayerDelegate> playerDelegate;

- (id)initWithUrl:(NSURL *)url;

- (void)play;
- (void)pause;
- (void)stop;
- (void)continuePlay;
- (void)seekTo:(NSTimeInterval)time;
- (void)replay;

- (void)finishPlay;
- (void)shutdown;
- (void)destroy;

#pragma mark - 语音功能
@property (nonatomic, strong) ONTPlayerVoiceSession *voiceSession;
@property (nonatomic, readonly) BOOL isAudioPushing;

- (void)startPushingAudio;
- (void)stopPushingAudio;
//- (void)pushAudioData:(NSData *)data timestamp:(uint64_t)timestamp;

@end


NS_ASSUME_NONNULL_END
