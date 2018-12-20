//
//  ONTPlayerVoiceSession.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/11/15.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//@class ONTPlayer;

@protocol ONTPlayerVoiceSessionDelegate <NSObject>

- (void)voiceSessionNeedPushData:(NSData *)data timestamp:(uint64_t)timestamp;

@end

@interface ONTPlayerVoiceSession : NSObject

@property (nonatomic) BOOL isVoiceConnected;
@property (nonatomic, weak) id<ONTPlayerVoiceSessionDelegate> sessionDelegate;

- (void)startVoiceConnection;
- (void)stopVoiceConnection;

@end

NS_ASSUME_NONNULL_END
