//
//  WBNetworkingTools.h
//  Weibo
//
//  Created by 卢中华 on 2016/11/7.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
// 网络请求方式
typedef enum: NSInteger {
    GET,
    POST
} WBNetworkMethod;

@interface WBNetworkingTools : AFHTTPSessionManager
// 网络工具单例
+ (instancetype)sharedTools;
// 请求授权 URL
- (NSURL *)loadOauthURL;
// 获取 access_token
- (void)loadAccess_tokenWithCode: (NSString *)code finished:(void (^)(id responseObject, NSError *error))finished;
// 加载用户信息
- (void)loadAccountInfoWithToken: (NSString *)token uid: (NSString *)uid finished:(void (^)(id responseObject, NSError *error))finished;
// 加载微博数据
- (void)loadStatusWithSince_id: (int)since_id max_id: (int)max_id finished:(void (^)(id responseObject, NSError *error))finished;
@end
