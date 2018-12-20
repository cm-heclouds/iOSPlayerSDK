//
//  ONTPlayerControllBar.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONTPlayer.h"

NS_ASSUME_NONNULL_BEGIN

#define ONTPLAYERDEFAULTWIDTH [UIScreen mainScreen].bounds.size.width

@protocol ONTPlayerControllBarDeleage <NSObject>

- (void)playerControllStart;
- (void)playerControllStop;
- (void)playerControllReplay;
- (void)playerControllSeekToTime:(CGFloat)time;
- (void)playerControllSwitchFullScreen:(BOOL)isFullScreen;
- (void)playerControllExit;
- (void)playerControllLoadOverTime;

- (void)playerControllSaveScreenshotSuccess;
- (void)playerControllSaveScreenshotError:(NSError *)error;

@end


@interface ONTPlayerControllBar : UIView

@property (nonatomic) NSTimeInterval totalLength;

@property (nonatomic, weak) id<ONTPlayerControllBarDeleage> delegate;
@property (nonatomic, strong) ONTPlayer *player;
@property (nonatomic) ONTPlayerType playerType;
//@property (nonatomic) BOOL isLive;

- (id)initWithPlayer:(ONTPlayer *)player;
- (void)startPlay;
- (void)finishPlay;

- (void)saveCurrentScreenshot;


@end

NS_ASSUME_NONNULL_END
