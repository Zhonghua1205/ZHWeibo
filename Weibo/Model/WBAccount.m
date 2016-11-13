//
//  WBAccount.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/7.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "WBAccount.h"

@interface WBAccount ()<NSCoding>

@end

@implementation WBAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    return [[self alloc] accountWithDict:dict];
}
- (instancetype)accountWithDict:(NSDictionary *)dict {
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
// 保存账户信息
- (void)saveAccountInfoWithAccount: (WBAccount *)account {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *savePath = [path stringByAppendingPathComponent:@"account.plist"];
    [NSKeyedArchiver archiveRootObject:account toFile:savePath];
}
// 归档
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.access_token forKey:@"access_token"];
    [coder encodeObject:self.uid forKey:@"uid"];
    [coder encodeObject:self.expires_in forKey:@"expires_in"];
    [coder encodeObject:self.screen_name forKey:@"screen_name"];
    [coder encodeObject:self.avatar_large forKey:@"avatar_large"];
}
// 解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
    self.uid = [aDecoder decodeObjectForKey:@"uid"];
    self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
    self.screen_name = [aDecoder decodeObjectForKey:@"screen_name"];
    self.avatar_large = [aDecoder decodeObjectForKey:@"avatar_large"];
    return self;
}
@end
