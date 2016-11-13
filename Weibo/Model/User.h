//
//  User.h
//  Weibo
//
//  Created by 卢中华 on 2016/11/7.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
// screen_name 用户昵称
@property (nonatomic, strong) NSString *screen_name;
// profile_image_url 用户头像地址（中图），50×50像素
@property (nonatomic, strong) NSString *profile_image_url;
// verified_type int
@property (nonatomic, assign) int verified_type;
// mbrank 会员等级
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign) int id;

+ (instancetype)userWithDict: (NSDictionary *)dict;
@end
