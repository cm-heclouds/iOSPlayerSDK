//
//  LoginInputView.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/17.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "LoginInputView.h"

@implementation LoginInputView

- (id)init {
    self = [super init];
    if (self) {
        [self addViews];
        [self layoutViews];
    }
    return self;
}

- (void)addViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.textField];
    [self addSubview:self.separator];
}

- (void)layoutViews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self).offset(4);
        make.width.mas_equalTo(100);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(16);
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self.titleLabel);
    }];
    
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(LINE_WIDTH);
        make.bottom.equalTo(self);
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT(16);
        _titleLabel.textColor = RGBColor(90, 97, 105);
    }
    return _titleLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = RGBColor(90, 97, 105);
        _textField.font = FONT(16);
    }
    return _textField;
}

- (UIView *)separator {
    if (!_separator) {
        _separator = [[UIView alloc] init];
//        _separator.backgroundColor = [UIColor blackColor];
        _separator.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }
    return _separator;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
