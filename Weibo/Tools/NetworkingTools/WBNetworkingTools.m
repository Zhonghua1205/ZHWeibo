//
//  WBNetworkingTools.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/7.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "WBNetworkingTools.h"
#import "UserAccountViewModel.h"
@interface WBNetworkingTools ()

@end

@implementation WBNetworkingTools
// 网络工具类单例
+ (instancetype)sharedTools {
    static WBNetworkingTools *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[WBNetworkingTools alloc] initWithBaseURL:nil];
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    });
    return tools;
}

// 加载微博数据
/**
 参数列表:
 URL: https://api.weibo.com/2/statuses/home_timeline.json
 access_token: 授权获取到的 token
 since_id: 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
 max_id: 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
- (void)loadStatusWithSince_id: (int)since_id max_id: (int)max_id finished:(void (^)(id responseObject, NSError *error))finished {
    if (![UserAccountViewModel sharedAccount].account) {
        NSLog(@"没有授权，无法加载数据");
        return;
    }
    NSString *token = [UserAccountViewModel sharedAccount].account.access_token;
    NSString *urlString = @"https://api.weibo.com/2/statuses/home_timeline.json";
//    NSDictionary *parameters = [NSDictionary dictionary];
//    if (since_id > 0) {
//        parameters = @{@"access_token" : token, @"since_id" : @(since_id)};
//    }else {
//        parameters = @{@"access_token" : token, @"max_id" : @(max_id)};
//    }
    NSDictionary *parameters = @{@"access_token" : token};
    [self requestMethod:GET URLString:urlString parameters:parameters finished:finished];
}

// 加载用户信息
/**
 参数列表:
 URL: https://api.weibo.com/2/users/show.json
 access_token: 授权获取到的 token
 uid: 需要查询的用户ID
 */
- (void)loadAccountInfoWithToken: (NSString *)token uid: (NSString *)uid finished:(void (^)(id responseObject, NSError *error))finished {
    NSString *urlString = @"https://api.weibo.com/2/users/show.json";
    NSDictionary *parameters = @{@"access_token" : token, @"uid" : uid};
    [self requestMethod:GET URLString:urlString parameters:parameters finished:finished];
}

// 获取 token
/**
 参数列表:
 URL: https://api.weibo.com/oauth2/access_token
 client_id         App Key:611165914
 client_secret     App Secret：278f8907a6f01941c2281c9958396720
 grant_type        authorization_code
 code              请求 OAuth 授权获取的 code
 redirect_uri      授权回调地址 授权回调页：http://www.baidu.com
 */
- (void)loadAccess_tokenWithCode: (NSString *)code finished:(void (^)(id responseObject, NSError *error))finished {
    NSString *urlString = @"https://api.weibo.com/oauth2/access_token";
    NSDictionary *parameters = @{@"client_id" : @"611165914",
                                 @"client_secret" : @"278f8907a6f01941c2281c9958396720",
                                 @"grant_type" : @"authorization_code",
                                 @"code" : code,
                                 @"redirect_uri" : @"http://www.baidu.com"};
    [self requestMethod:POST URLString:urlString parameters:parameters finished:finished];
}

// 请求 OAuth 授权来获取 code 的 URL
/**
 参数列表:
 URL: https://api.weibo.com/oauth2/authorize
 client_id:       申请应用时分配的AppKey. App Key:611165914
 redirect_uri:    授权回调地址 授权回调页：http://www.baidu.com
 */
- (NSURL *)loadOauthURL {
    NSString *client_id = @"client_id";
    NSString *appKey = @"611165914";
    NSString *redirect_uri = @"redirect_uri";
    NSString *rediURL = @"http://www.baidu.com";
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?%@=%@&%@=%@",client_id,appKey,redirect_uri,rediURL];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

// 封装 AFNetworking 的网络方法
- (void)requestMethod: (WBNetworkMethod)method URLString: (NSString *)url parameters:(id)parameters finished:(void (^)(id responseObject, NSError *error))finished {
    if (method == GET) {
        [self GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil, error);
        }];
    }else {
        [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil, error);
        }];
    }
}
@end
