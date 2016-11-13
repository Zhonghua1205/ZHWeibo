//
//  WBStatus.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/7.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "WBStatus.h"

@interface WBStatus ()

@end

@implementation WBStatus
+ (instancetype)statusWithDict:(NSDictionary *)dict {
    return [[self alloc] statusWithDict:dict];
}
- (instancetype)statusWithDict:(NSDictionary *)dict {
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key  isEqual: @"user"]) {
        if (value != nil) {
            NSDictionary *dict = value;
            self.user = [User userWithDict:dict];
        }
        return;
    }
    [super setValue:value forKey:key];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (NSString *)description {
    NSArray *keys = @[@"created_at",@"id",@"idstr",@"text",@"source"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}
@end
