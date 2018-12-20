//
//  ONTPlayerActionBar.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/11/2.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONTPlayerConst.h"
#import "ONTPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ONTPlayerActionBarDeleage <NSObject>

- (void)playerActionSaveScreenshotSuccess;
- (void)playerActionSaveScreenshotError:(NSError *)error;

@end

@interface ONTPlayerActionBar : UIView

- (id)initWithPlayer:(ONTPlayer *)player;;
- (void)switchFullScreen:(BOOL)isFullScreen;

@property (nonatomic, strong) ONTPlayer *player;
@property (nonatomic) ONTPlayerType playerType;

@property (nonatomic, weak) id <ONTPlayerActionBarDeleage> delegate;

@end

NS_ASSUME_NONNULL_END
