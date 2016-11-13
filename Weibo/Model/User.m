//
//  User.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/7.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "User.h"

@interface User ()

@end

@implementation User
+ (instancetype)userWithDict:(NSDictionary *)dict {
    return [[self alloc] userWithDict:dict];
}
- (instancetype)userWithDict:(NSDictionary *)dict {
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
@end
