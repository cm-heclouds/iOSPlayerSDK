//
//  LiveSelectionCell.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveSelectionCell : UITableViewCell

@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *titleArray;

@end

@interface LiveSelectionButton : UIButton

@end
