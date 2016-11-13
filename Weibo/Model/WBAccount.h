//
//  WBAccount.h
//  Weibo
//
//  Created by 卢中华 on 2016/11/7.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject

/**
 access_token:  "access_token" = "2.00yPjkKC0kK53f6019486fe34WFwGD";
 expires_in: 过期时间  "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 1991166082;
 */
// token
@property (nonatomic, strong) NSString *access_token;
// 过期时间
@property (nonatomic, strong) NSNumber *expires_in;
//
@property (nonatomic, strong) NSString *remind_in;
// uid
@property (nonatomic, strong) NSString *uid;
// screen_name
@property (nonatomic, strong) NSString *screen_name;
// avatar_large
@property (nonatomic, strong) NSString *avatar_large;
// 字典转模型
+ (instancetype)accountWithDict:(NSDictionary *)dict;
// 保存用户信息
- (void)saveAccountInfoWithAccount: (WBAccount *)account;
@end
