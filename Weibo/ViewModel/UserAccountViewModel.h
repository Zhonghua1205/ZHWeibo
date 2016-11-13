//
//  UserAccountViewModel.h
//  Weibo
//
//  Created by 卢中华 on 2016/11/9.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBAccount.h"
@interface UserAccountViewModel : NSObject
@property (nonatomic, strong) WBAccount *account;
+ (instancetype)sharedAccount;
@end
