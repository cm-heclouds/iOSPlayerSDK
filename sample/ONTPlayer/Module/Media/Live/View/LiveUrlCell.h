//
//  LiveURLCell.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveUrlCell : UITableViewCell

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIButton *getUrlButton;
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UITextView *urlTextView;

@end
