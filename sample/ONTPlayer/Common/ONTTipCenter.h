//
//  ONTTipCenter.h
//  ONTLive
//
//  Created by 汤世宇 on 2018/8/28.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface ONTTipCenter : NSObject

+ (void)showSuccessTip:(NSString *)tip;

+ (void)showFailTip:(NSString *)tip;

+ (void)showLoadingTip:(NSString *)tip;

+ (void)dismissHud;
@end
