//
//  MediaTypeView.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "MediaTypeView.h"

@implementation MediaTypeView

- (id)init {
    self = [super init];
    if (self) {
        [self addViews];
        [self layoutViews];
    }
    return self;
}

- (void)addViews {
    [self addSubview:self.typeButton];
    [self addSubview:self.typeLabel];
    [self addSubview:self.typeIcon];
}

- (void)layoutViews {
    [self.typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);
    }];
    
    [self.typeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.width.height.mas_equalTo(6);
    }];
}

- (UIButton *)typeButton {
    if (!_typeButton)  {
        _typeButton = [[UIButton alloc] init];
    }
    return _typeButton;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textColor = RGBColor(57, 62, 76);
        _typeLabel.font = FONT(18);
        _typeLabel.text = @"视频直播";
    }
    return _typeLabel;
}

- (UIImageView *)typeIcon {
    if (!_typeIcon) {
        _typeIcon = [[UIImageView alloc] init];
        _typeIcon.image = IMAGE(@"media_select_icon");
    }
    return _typeIcon;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
