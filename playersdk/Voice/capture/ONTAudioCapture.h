//
//  ONTAudioCapture.h
//  ONTLive
//
//  Created by 汤世宇 on 2018/8/23.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>
#import "ONTLiveAudioConfiguration.h"

extern NSString *_Nullable const ONTAudioComponentFailedToCreateNotification;

@class ONTAudioCapture;
/** LFAudioCapture callback audioData */
@protocol ONTAudioCaptureDelegate <NSObject>
- (void)captureOutput:(nullable ONTAudioCapture *)capture audioData:(nullable NSData*)audioData;
@end

@interface ONTAudioCapture : NSObject

@property (nullable, nonatomic, weak) id<ONTAudioCaptureDelegate> delegate;

/** The muted control callbackAudioData,muted will memset 0.*/
@property (nonatomic, assign) BOOL muted;

/** The running control start capture or stop capture*/
@property (nonatomic, assign) BOOL running;

#pragma mark - Initializer
///=============================================================================
/// @name Initializer
///=============================================================================
- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (nullable instancetype)new UNAVAILABLE_ATTRIBUTE;
 
/**
 The designated initializer. Multiple instances with the same configuration will make the
 capture unstable.
 */
- (nullable instancetype)initWithAudioConfiguration:(nullable ONTLiveAudioConfiguration *)configuration NS_DESIGNATED_INITIALIZER;


@end
