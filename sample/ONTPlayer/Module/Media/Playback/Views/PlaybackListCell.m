//
//  PlaybackListCell.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "PlaybackListCell.h"

@implementation PlaybackListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
        [self layoutViews];
        [self testData];
    }
    return self;
}

- (void)testData {
    self.videoImageView.image = IMAGE(@"media_list_default");
    self.videoSizeLabel.text = @"31M";
    self.videoTitleLabel.text = @"串口驱动程序设计_P.wmv";
//    self.videoLengthLabel.text = @"时间 : 01:23:12";
}

- (void)addViews {
    [self addSubview:self.videoImageView];
    [self addSubview:self.videoTitleLabel];
    [self addSubview:self.videoLengthLabel];
    [self addSubview:self.videoSizeLabel];
    [self addSubview:self.separator];
}

- (void)layoutViews {
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(16);
        make.bottom.equalTo(self).offset(-16);
        make.width.equalTo(self.videoImageView.mas_height).multipliedBy(5/3.0);
    }];
    
    [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoImageView.mas_right).offset(12);
        make.top.equalTo(self.videoImageView).offset(4);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self.videoLengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoTitleLabel);
        make.bottom.equalTo(self.videoImageView);
        make.right.equalTo(self.videoSizeLabel.mas_left).offset(-6);
    }];
    
    [self.videoSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.videoLengthLabel);
        make.right.equalTo(self).offset(-16);
        make.width.mas_equalTo(56);
    }];
    
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(LINE_WIDTH);
    }];
}

- (void)setDuration:(NSTimeInterval)duration {
    _duration = duration;
    int temp = (int)round(duration);
    int second = temp % 60;
    int minute = temp / 60 % 60;
    int hour = temp / 60 / 60;
    self.videoLengthLabel.text = [NSString stringWithFormat: @"%02d:%02d:%02d", hour, minute, second];
}

- (void)setFileSize:(long long)fileSize {
    _fileSize = fileSize;
    
    long long GB = fileSize / (1024 * 1024 * 1024);
    if (GB >= 1) {
        self.videoSizeLabel.text = [NSString stringWithFormat:@"%.02lfGB", fileSize / (1024 * 1024 * 1024.f)];
    } else {
        self.videoSizeLabel.text = [NSString stringWithFormat:@"%.02lfMB", fileSize / (1024 * 1024.f)];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.videoTitleLabel.text = title;
}

- (UIImageView *)videoImageView {
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImageView.clipsToBounds = YES;
    }
    return _videoImageView;
}

- (UILabel *)videoTitleLabel {
    if (!_videoTitleLabel) {
        _videoTitleLabel = [[UILabel alloc] init];
        _videoTitleLabel.textColor = RGBColor(57, 62, 76);
        _videoTitleLabel.font = FONT(16);
        _videoTitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _videoTitleLabel;
}

- (UILabel *)videoLengthLabel {
    if (!_videoLengthLabel) {
        _videoLengthLabel = [[UILabel alloc] init];
        _videoLengthLabel.textColor = RGBColor(143, 149, 155);
        _videoLengthLabel.font = FONT(12);
        _videoLengthLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _videoLengthLabel;
}

- (UILabel *)videoSizeLabel {
    if (!_videoSizeLabel) {
        _videoSizeLabel = [[UILabel alloc] init];
        _videoSizeLabel.textColor = RGBColor(143, 149, 155);
        _videoSizeLabel.font = FONT(12);
        _videoSizeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _videoSizeLabel;
}

- (UIView *)separator {
    if (!_separator) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
    }
    return _separator;
}


@end
