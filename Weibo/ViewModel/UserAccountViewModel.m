//
//  UserAccountViewModel.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/9.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "UserAccountViewModel.h"


@interface UserAccountViewModel ()

@property (nonatomic, strong) NSString *deCodePath;

@end

@implementation UserAccountViewModel
+ (instancetype)sharedAccount {
    static UserAccountViewModel *viewModel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        viewModel = [[UserAccountViewModel alloc] init];
    });
    
    return viewModel;
}

- (NSString *)deCodePath {
    if (_deCodePath == nil) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        _deCodePath = [path stringByAppendingPathComponent:@"account.plist"];
    }
    return _deCodePath;
}

- (instancetype)init {
    if (self == [super init]) {
        self.account = [NSKeyedUnarchiver unarchiveObjectWithFile:self.deCodePath];
    }
    NSLog(@"%@",self.account.access_token);
    return self;
}


@end
