//
//  UIImage+Extention.m
//  miwenp
//
//  Created by 汤世宇 on 2018/7/3.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = (CGRect){{0, 0}, size};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
