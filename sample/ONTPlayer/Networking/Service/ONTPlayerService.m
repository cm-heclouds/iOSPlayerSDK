//
//  ONTPlayerService.m
//  ONTPlayer
//
//  Created by 汤世宇 on 2018/9/20.
//  Copyright © 2018年 汤世宇. All rights reserved.
//

#import "ONTPlayerService.h"
#import "AFNetworking.h"
#import "CTNetworking.h"

@interface ONTPlayerService ()

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequestSerializer;

@end

@implementation ONTPlayerService
#pragma mark - public methods
- (NSURLRequest *)requestWithParams:(NSDictionary *)params methodName:(NSString *)methodName requestType:(CTAPIManagerRequestType)requestType
{
    if (requestType == CTAPIManagerRequestTypeGet) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, methodName];
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:params error:nil];
        [request setValue:[PlayerInfoManager shareManager].apiKey forHTTPHeaderField:@"api-key"];
        NSLog(@"get request - %@", request);
        return request;
    } else if (requestType == CTAPIManagerRequestTypePost) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, methodName];
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil]];
//        NSMutableURLRequest *request = [self.jsonRequestSerializer requestWithMethod:@"POST" URLString:self.baseURL parameters:params error:nil];
        [request setValue:[PlayerInfoManager shareManager].apiKey forHTTPHeaderField:@"api-key"];
        NSLog(@"post request - %@", request);
        NSLog(@"post params - %@", params);
        return request;
    } else if (requestType == CTAPIManagerRequestTypePut) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, methodName];
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:urlString parameters:params error:nil];
        [request setValue:[PlayerInfoManager shareManager].apiKey forHTTPHeaderField:@"api-key"];
        return request;
    } else if (requestType == CTAPIManagerRequestTypeDelete) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, methodName];
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlString parameters:params error:nil];
        [request setValue:[PlayerInfoManager shareManager].apiKey forHTTPHeaderField:@"api-key"];
        return request;
    }
//    else if (requestType == CTAPIManagerRequestTypePatch) {
//        NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, methodName];
//        NSMutableURLRequest *request = [self.jsonRequestSerializer requestWithMethod:@"PATCH" URLString:urlString parameters:params error:nil];
//        [request setValue:[PlayerInfoManager shareManager].apiKey forHTTPHeaderField:@"api-key"];
//        return request;
//    }
    return nil;
}

- (NSDictionary *)resultWithResponseData:(NSData *)responseData response:(NSURLResponse *)response request:(NSURLRequest *)request error:(NSError **)error {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    if (responseData) {
        result[kCTApiProxyValidateResultKeyResponseData] = responseData;
        result[kCTApiProxyValidateResultKeyResponseJSONString] = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        result[kCTApiProxyValidateResultKeyResponseJSONObject] = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL];
    }
    return result;
}

- (NSString *)getBaseUrl {
    return self.baseURL;
}

#pragma mark - getters and setters
- (NSString *)baseURL {
    if (self.apiEnvironment == CTServiceAPIEnvironmentRelease) {
        return @"http://api.heclouds.com/ipc/video";
    } else if (self.apiEnvironment == CTServiceAPIEnvironmentReleaseCandidate) {
        return @"http://api.heclouds.com/ipc/video";
    } else {
        return @"http://api.heclouds.com";
    }
}

- (CTServiceAPIEnvironment)apiEnvironment {
#if ONTLiveDEV
    return CTServiceAPIEnvironmentDevelop;
#elif ONTLiveTEST
    return CTServiceAPIEnvironmentReleaseCandidate;
#else
    return CTServiceAPIEnvironmentRelease;
#endif
}

- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        [_httpRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _httpRequestSerializer;
}

- (AFJSONRequestSerializer *)jsonRequestSerializer {
    if (_jsonRequestSerializer == nil) {
        _jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    }
    return _jsonRequestSerializer;
}


@end
