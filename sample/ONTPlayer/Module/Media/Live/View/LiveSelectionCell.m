//
//  LiveSelectionCell.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "LiveSelectionCell.h"

@interface LiveSelectionCell ()

@end

@implementation LiveSelectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectedIndex = 0;
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    for (int i = 0; i < titleArray.count; i++) {
        LiveSelectionButton *button = [[LiveSelectionButton alloc] init];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(24 + 102*i, 3, 96, 44);
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0) {
            button.selected = YES;
        }
    }
}

- (void)selectButtonAction:(UIButton *)sender {
    for (int i = 0; i < _titleArray.count; i++) {
        LiveSelectionButton *button = [self viewWithTag: 1000 + i];
        button.selected = NO;
    }
    sender.selected = YES;
    self.selectedIndex = sender.tag - 1000;
}

@end

#pragma mark - LiveSelectionButton
@implementation LiveSelectionButton

- (id)init {
    self = [super init];
    if (self) {
        [self setImage:IMAGE(@"media_button_normal") forState:UIControlStateNormal];
        [self setImage:IMAGE(@"media_button_selected") forState:UIControlStateSelected];
        [self setTitleColor:RGBColor(90, 97, 105) forState:UIControlStateNormal];
        self.titleLabel.font = FONT(14);
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 15, 14, 14);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(22, 15, 80, 14);
}

@end
