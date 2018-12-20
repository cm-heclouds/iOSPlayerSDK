//
//  ONTPlayerNetManager.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/10/24.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ONTPlayerNetManager.h"
#import "Reachability.h"

@implementation ONTPlayerNetManager

+ (int)internetStatus {
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    int status = 0;
    switch (internetStatus) {
        case ReachableViaWiFi:
            status = 1;
            break;
        case ReachableViaWWAN:
            status = 2;
            break;
        case NotReachable:
            status = 0;
        default:
            break;
    }
    
    return status;
}


@end
