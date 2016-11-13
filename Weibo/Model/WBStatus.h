//
//  WBStatus.h
//  Weibo
//
//  Created by 卢中华 on 2016/11/7.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface WBStatus : NSObject
// 微博创建时间
@property (nonatomic, strong) NSString *created_at;
// id int64
@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString *idstr;
// text 微博信息内容
@property (nonatomic, strong) NSString *text;
// source 微博来源
@property (nonatomic, strong) NSString *source;
//pic_urls
@property (nonatomic, strong) NSArray *pic_urls;
// thumbnail_pic 缩略图片地址，没有时不返回此字段
@property (nonatomic, strong) NSString *thumbnail_pic;
// bmiddle_pic 中等尺寸图片地址，没有时不返回此字段
@property (nonatomic, strong) NSString *bmiddle_pic;
// original_pic 原始图片地址，没有时不返回此字段
@property (nonatomic, strong) NSString *original_pic;
// user 微博作者的用户信息字段
@property (nonatomic, strong) User *user;
// retweeted_status 被转发的原微博信息字段，当该微博为转发微博时返回
@property (nonatomic, strong) WBStatus *retweeted_status;

+ (instancetype)statusWithDict: (NSDictionary *)dict;
//
@end
