//
//  StatusesListViewModel.h
//  Weibo
//
//  Created by 卢中华 on 2016/11/9.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBStatus.h"
#import "StatusViewModel.h"
@interface StatusesListViewModel : NSObject
@property (nonatomic, strong) NSArray *statusList;
//@property (nonatomic, strong) StatusViewModel *statusViewModel;
+ (instancetype)sharedListViewModel;
- (void)loadStatusIsPullUp:(BOOL)isPullUp finished:(void (^)(BOOL isSuccessed))finished;
@end
