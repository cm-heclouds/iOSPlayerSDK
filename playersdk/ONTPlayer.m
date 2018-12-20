//
//  ONTPlayer.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ONTPlayer.h"
#import <IJKMediaFrameworkWithSSL/IJKMediaFrameworkWithSSL.h>
#import "ONTPlayerControllBar.h"
#import "ONTPlayerVoiceSession.h"

@interface ONTPlayer () {
   
}

@property (nonatomic, strong) IJKFFMoviePlayerController *ffPlayer;
@property (nonatomic, strong) IJKAVMoviePlayerController *avPlayer;

@end


@implementation ONTPlayer

- (id)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
        _isLocalVideo = NO;
        if ([self.url.absoluteString hasPrefix:@"file"]) {
            _isLocalVideo = YES;
        }
        [self installMovieNotificationObservers];
    }
    return self;
}

- (id)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        _urlString = urlString;
        _isLocalVideo = NO;
        if ([self.urlString hasPrefix:@"file"]) {
            _url = [NSURL fileURLWithPath:_urlString];
            _isLocalVideo = YES;
        } else {
            _url = [NSURL URLWithString:_urlString];
        }
        [self installMovieNotificationObservers];
    }
    return self;
}

- (void)play {
    if (_isLocalVideo) {
        [self.avPlayer prepareToPlay];
        [self.avPlayer play];
    } else {
        [self.ffPlayer prepareToPlay];
        [self.ffPlayer play];
    }
}

- (void)continuePlay {
    if (_isLocalVideo) {
        [self.avPlayer play];
    } else {
        [self.ffPlayer play];
    }
}

- (void)replay {
    if (_isLocalVideo) {
        [self.avPlayer play];
    } else {
//        [self.ffPlayer shutdown];
//        self.ffPlayer = nil;
//        self.ffPlayer.currentPlaybackTime = 0;
        [self.ffPlayer prepareToPlay];
        [self.ffPlayer play];
//        [self.ffPlayer replay];
    }
}

- (void)pause {
    _isLocalVideo? [self.avPlayer pause] : [self.ffPlayer pause];
}

- (void)stop {
    _isLocalVideo? [self.avPlayer stop] : [self.ffPlayer stop];
}

- (void)shutdown {
    _isLocalVideo? [self.avPlayer shutdown] : [self.ffPlayer shutdown];
}

- (void)finishPlay {
    if (_isAudioPushing) {
        [self stopPushingAudio];
    }
    [self shutdown];
    [self destroy];
}

- (void)seekTo:(NSTimeInterval)time {
    if (_isLocalVideo) {
        self.avPlayer.currentPlaybackTime = time;
    } else {
         self.ffPlayer.currentPlaybackTime = time;
    }
}

#pragma mark - Register observers for the various movie object notifications.
-(void)installMovieNotificationObservers {
    id object;
    if (_isLocalVideo) {
        object = self.avPlayer;
    } else {
        object = self.ffPlayer;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStateDidChange:) name:IJKMPMoviePlayerLoadStateDidChangeNotification  object:object];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:IJKMPMoviePlayerPlaybackDidFinishNotification  object:object];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaIsPreparedToPlayDidChange:) name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:object];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackStateDidChange:) name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:object];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(streamInfoDidFind:) name:IJKMPMoviePlayerFindStreamInfoNotification object:object];
    
}

- (void)streamInfoDidFind:(NSNotification*)notification {
    
}

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState;
    if (_isLocalVideo) {
        loadState = self.avPlayer.loadState;
    } else {
        loadState = self.ffPlayer.loadState;
    }
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if ([_playerDelegate respondsToSelector:@selector(loadStatusChanged:)]) {
            [_playerDelegate loadStatusChanged:ONTPlayerLoadStatusOK];
        }
        
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        if ([_playerDelegate respondsToSelector:@selector(loadStatusChanged:)]) {
            [_playerDelegate loadStatusChanged:ONTPlayerLoadStatusStalled];
        }
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification {
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            _playStatus = ONTPlayerPlayStatusEnded;
            if ([_playerDelegate respondsToSelector:@selector(playStatusChanged:)]) {
                [_playerDelegate playStatusChanged:ONTPlayerPlayStatusEnded];
            }            
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            _playStatus = ONTPlayerPlayStatusError;
            if ([_playerDelegate respondsToSelector:@selector(playStatusChanged:)]) {
                [_playerDelegate playStatusChanged:ONTPlayerPlayStatusError];
            }
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    if ([_playerDelegate respondsToSelector:@selector(playStatusChanged:)]) {
        [_playerDelegate playStatusChanged:ONTPlayerPlayStatusPrepared];
    }
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    IJKMPMoviePlaybackState state;
    if (_isLocalVideo) {
        state = _avPlayer.playbackState;
    } else {
        state = _ffPlayer.playbackState;
    }

    switch (state) {
        case IJKMPMoviePlaybackStateStopped: {
            _playStatus = ONTPlayerPlayStatusStopped;
            if ([_playerDelegate respondsToSelector:@selector(playStatusChanged:)]) {
                [_playerDelegate playStatusChanged:ONTPlayerPlayStatusStopped];
            }
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            _playStatus = ONTPlayerPlayStatusStart;
            if ([_playerDelegate respondsToSelector:@selector(playStatusChanged:)]) {
                [_playerDelegate playStatusChanged:ONTPlayerPlayStatusStart];
            }
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            _playStatus = ONTPlayerPlayStatusPaused;
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)state);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)state);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)state);
            break;
        }
    }
}


#pragma mark Remove Movie Notification Handlers
- (void)destroy {
    [self removeMovieNotificationObservers];
    if (_isLocalVideo) {
        self.avPlayer = nil;
    } else {
        self.ffPlayer = nil;
    }
}

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers {
    id object;
    if (_isLocalVideo) {
        object = _avPlayer;
    } else {
        object = _ffPlayer;
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:object];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:object];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:object];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:object];
}

- (BOOL)isPlaying {
    if (_isLocalVideo) {
        return self.avPlayer.isPlaying;
    } else {
        return self.ffPlayer.isPlaying;
    }
}

- (NSTimeInterval)duration {
    if (_isLocalVideo) {
        return self.avPlayer.duration;
    } else {
        return self.ffPlayer.duration;
    }
}

- (NSTimeInterval)currentPlaybackTime {
    if (_isLocalVideo) {
        return self.avPlayer.currentPlaybackTime;
    } else {
        return self.ffPlayer.currentPlaybackTime;
    }
}

- (void)setShouldAutoPlay:(BOOL)shouldAutoPlay {
    _shouldAutoPlay = shouldAutoPlay;
    if (_isLocalVideo) {
        self.avPlayer.shouldAutoplay = shouldAutoPlay;
    } else {
        self.ffPlayer.shouldAutoplay = shouldAutoPlay;
    }
}

- (IJKAVMoviePlayerController *)avPlayer {
    if (!_avPlayer) {
        _avPlayer = [[IJKAVMoviePlayerController alloc] initWithContentURL:self.url];
        _avPlayer.view.backgroundColor = [UIColor blackColor];
        _avPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _avPlayer.scalingMode = IJKMPMovieScalingModeAspectFit;
        _avPlayer.shouldAutoplay = YES ;
    
    }
    return _avPlayer;
}

- (IJKFFMoviePlayerController *)ffPlayer {
    if (!_ffPlayer) {
        [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
//        [options setFormatOptionIntValue:10 forKey:@"reconnect"];
//        [options setPlayerOptionIntValue:100 forKey:@"analyzeduration"];
//        [options setPlayerOptionIntValue:65536 forKey:@"probesize"];
//        [options setPlayerOptionIntValue:1 forKey:@"flush_packets"];
//        [options setPlayerOptionIntValue:1 forKey:@"packet-buffering"];
//        [options setPlayerOptionIntValue:0 forKey:@"framedrop"];
        [IJKFFMoviePlayerController setLogReport:NO];
        _ffPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:options];
        _ffPlayer.view.frame = CGRectZero;
        _ffPlayer.view.backgroundColor = [UIColor blackColor];
        _ffPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _ffPlayer.scalingMode = IJKMPMovieScalingModeAspectFit;
        _ffPlayer.shouldAutoplay = YES ;
    }
    return _ffPlayer;
}

- (UIView *)playerPreview {
    return _isLocalVideo ? self.avPlayer.view : self.ffPlayer.view;
}

- (UIImage *)screenshot {
    if (_isLocalVideo) {
        return self.avPlayer.thumbnailImageAtCurrentTime;
    } else {
        return self.ffPlayer.thumbnailImageAtCurrentTime;
    }
}

#pragma mark - 语音功能
- (void)voiceSessionNeedPushData:(NSData *)data timestamp:(uint64_t)timestamp {
    [self.ffPlayer pushAudioData:data timestamp:timestamp];
}

- (void)startPushingAudio {
    [self.voiceSession startVoiceConnection];
    _isAudioPushing = YES;
}

- (void)stopPushingAudio {
    [self.voiceSession stopVoiceConnection];
    _isAudioPushing = NO;
}

- (ONTPlayerVoiceSession *)voiceSession {
    if (!_voiceSession) {
        _voiceSession = [[ONTPlayerVoiceSession alloc] init];
        _voiceSession.sessionDelegate = self;
    }
    return _voiceSession;
}

@end
