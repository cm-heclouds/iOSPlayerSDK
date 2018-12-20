//
//  ONTTipCenter.m
//  ONTLive
//
//  Created by 汤世宇 on 2018/8/28.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ONTTipCenter.h"

@implementation ONTTipCenter

+ (void)showSuccessTip:(NSString *)tip {
    [SVProgressHUD showSuccessWithStatus:tip];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD dismissWithDelay:1];
}

+ (void)showFailTip:(NSString *)tip {
    [SVProgressHUD showErrorWithStatus:tip];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD dismissWithDelay:1];
}

+ (void)showLoadingTip:(NSString *)tip {
    [SVProgressHUD showWithStatus:tip];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

+ (void)dismissHud {
    [SVProgressHUD dismiss];
}
@end
