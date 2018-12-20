//
//  PlayerController.h
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/18.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "BaseViewController.h"

@interface PlayerController : UIViewController

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *videoName;

@property (nonatomic) BOOL isLive;



@end
