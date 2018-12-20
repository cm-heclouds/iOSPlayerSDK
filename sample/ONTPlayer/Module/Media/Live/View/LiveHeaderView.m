//
//  LiveHeaderView.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "LiveHeaderView.h"

@implementation LiveHeaderView

- (id)init {
    self = [super init];
    if (self) {
        [self addViews];
        [self layoutViews];
    }
    return self;
}

- (void)addViews {
    [self addSubview:self.titleLine];
    [self addSubview:self.titleLabel];
}

- (void)layoutViews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(32);
        make.centerY.equalTo(self);
    }];
    
    [self.titleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(24);
        make.width.mas_equalTo(1);
        make.centerY.equalTo(self);
        make.height.equalTo(self.titleLabel);
    }];
}

- (UIView *)titleLine {
    if (!_titleLine) {
        _titleLine = [[UIView alloc] init];
        _titleLine.backgroundColor = RGBColor(57, 72, 76);
    }
    return _titleLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = RGBColor(57, 72, 76);
        _titleLabel.font = FONT(16);
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
