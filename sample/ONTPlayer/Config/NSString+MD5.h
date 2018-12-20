//
//  NSString+MD5.h
//  ONTLive
//
//  Created by 汤世宇 on 2018/8/28.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

+ (NSString *)MD5String:(NSString *)string;

- (NSString *)MD5String;

@end
