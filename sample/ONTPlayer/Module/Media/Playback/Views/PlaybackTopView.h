//
//  PlaybackTopView.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaybackTopViewDelegate <NSObject>

- (void)topViewDidSelectedIndex:(int)selectedIndex;

@end

@interface PlaybackTopView : UIView

@property (nonatomic, weak) id<PlaybackTopViewDelegate> delegate;
@property (nonatomic) int selectedIndex;

@end
