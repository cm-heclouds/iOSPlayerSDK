//
//  LiveURLCell.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "LiveUrlCell.h"

@implementation LiveUrlCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addViews];
        [self layoutViews];
    }
    return self;
}

- (void)addViews {
    [self addSubview:self.urlTextView];
    [self addSubview:self.getUrlButton];
    [self addSubview:self.separator];
}

- (void)layoutViews {
    [self.urlTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self).offset(-2);
        make.right.equalTo(self).offset(-120);
        make.height.mas_equalTo(40);
    }];
    
    [self.getUrlButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(86);
        make.height.mas_equalTo(32);
    }];
    
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(LINE_WIDTH);
    }];
}

- (void)setUrl:(NSString *)url {
    _url = url;
    self.urlTextView.text = url;
}

- (UIButton *)getUrlButton {
    if (!_getUrlButton)  {
        _getUrlButton = [[UIButton alloc] init];
        [_getUrlButton setTitle:@"点击获取" forState:UIControlStateNormal];
        [_getUrlButton setTitleColor:RGBColor(27, 187, 255) forState:UIControlStateNormal];
        _getUrlButton.titleLabel.font = FONT(14);
        _getUrlButton.layer.borderColor = RGBColor(27, 187, 255).CGColor;
        _getUrlButton.layer.borderWidth = 1;
    }
    return _getUrlButton;
}

- (UITextView *)urlTextView {
    if (!_urlTextView) {
        _urlTextView = [[UITextView alloc] init];
        _urlTextView.textColor = RGBColor(90, 97, 105);
        _urlTextView.font = FONT(14);
        _urlTextView.bounces = NO;
        _urlTextView.showsVerticalScrollIndicator = NO;
//        _urlTextView.editable = NO;
//        _urlTextView.selectable = NO;
    }
    return _urlTextView;
}

- (UIView *)separator {
    if (!_separator) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
    }
    return _separator;
}

@end
