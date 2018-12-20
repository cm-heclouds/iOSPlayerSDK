//
//  ONTPlayerConst.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/11/2.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#ifndef ONTPlayerConst_h
#define ONTPlayerConst_h

#define ONTPlayerDidStartPlayingNotification @"ONTPlayerDidStartPlaying"

typedef enum {
    ONTPlayerTypeLive,
    ONTPlayerTypeVod
} ONTPlayerType;

typedef enum {
    ONTPlayerLoadStatusOK,
    ONTPlayerLoadStatusStalled
} ONTPlayerLoadStatus;

typedef enum {
    ONTPlayerPlayStatusPrepared,
    ONTPlayerPlayStatusStart,
    ONTPlayerPlayStatusPaused,
    ONTPlayerPlayStatusStopped,
    ONTPlayerPlayStatusEnded,
    ONTPlayerPlayStatusInterrupted,
    ONTPlayerPlayStatusSeeking,
    ONTPlayerPlayStatusError
} ONTPlayerPlayStatus;


#endif /* ONTPlayerConst_h */
