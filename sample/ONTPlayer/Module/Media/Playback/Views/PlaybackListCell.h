//
//  PlaybackListCell.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaybackListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UILabel *videoTitleLabel;
@property (nonatomic, strong) UILabel *videoLengthLabel;
@property (nonatomic, strong) UILabel *videoSizeLabel;
@property (nonatomic, strong) UIView *separator;

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) long long fileSize;
@property (nonatomic, strong) NSString *title;

@end
