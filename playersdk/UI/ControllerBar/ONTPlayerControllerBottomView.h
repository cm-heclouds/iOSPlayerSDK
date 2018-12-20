//
//  ONTPlayerControllerBottomView.h
//  
//
//  Created by 汤世宇 on 2018/10/30.
//

#import <UIKit/UIKit.h>
#import "ONTPlayerConst.h"
NS_ASSUME_NONNULL_BEGIN


@interface ONTPlayerControllerBottomView : UIView

- (id)initWithType:(ONTPlayerType)type;

//共有
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *fullScreenButton;
@property (nonatomic, strong) UILabel *timeLabel;

//回放
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *totalLabel;

//直播
@property (nonatomic, strong) UIButton *refreshButton;

@end

NS_ASSUME_NONNULL_END
