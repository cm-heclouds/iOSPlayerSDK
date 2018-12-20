//
//  NoWifiTipView.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/10.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ONTPlayerTipViewDelegate <NSObject>

- (void)tipViewAction:(UIView *)tipView;

@end

@interface ONTPlayerTipView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *actionButton;


@property (nonatomic, weak) id<ONTPlayerTipViewDelegate> delegate;

- (id)initWithTitle:(NSString *)title message:(NSString *)message tag:(int)tag delegate:(id<ONTPlayerTipViewDelegate>)delegate;
- (void)showInView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
