//
//  StatusesListViewModel.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/9.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "StatusesListViewModel.h"



@implementation StatusesListViewModel

+ (instancetype)sharedListViewModel {
    static StatusesListViewModel *viewModel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        viewModel = [[StatusesListViewModel alloc] init];
    });
    return viewModel;
}

- (NSArray *)statusList {
    if (_statusList == nil) {
        _statusList = [[NSArray alloc] init];
    }
    return _statusList;
}
- (void)loadStatusIsPullUp:(BOOL)isPullUp finished:(void (^)(BOOL isSuccessed))finished {
    int max_id = 0;
    int since_id = 0;
    StatusViewModel *firstModel = [StatusesListViewModel sharedListViewModel].statusList.firstObject;
    int n = [firstModel.status.idstr intValue];
    NSLog(@"=>--------------%d",n);
//    if (!isPullUp) {
//        StatusViewModel *firstModel = [StatusesListViewModel sharedListViewModel].statusList.firstObject;
//        since_id = firstModel.status.id;
//    }else {
//        StatusViewModel *lastModel = [StatusesListViewModel sharedListViewModel].statusList.lastObject;
//        max_id = lastModel.status.id;
//    }
//    
//    NSLog(@"since_id  ====== %d",since_id);
//    NSLog(@"max_id  =======  %d",max_id);
    
    [[WBNetworkingTools sharedTools] loadStatusWithSince_id:since_id max_id:max_id finished:^(id responseObject, NSError *error) {
        if (error != nil) {
            NSLog(@"加载数据失败");
            NSLog(@"%@",error);
            finished(NO);
            return;
        }
        if (!responseObject) {
            NSLog(@"没有数据");
            return;
        }
        NSDictionary *reslut = responseObject;
        NSArray *value = reslut[@"statuses"];
        if (!value) {
            NSLog(@"数据格式有误");
            finished(NO);
            return;
        }
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.statusList.count];
        for (NSDictionary *dict in value) {
            WBStatus *status = [WBStatus statusWithDict:dict];
            NSLog(@"------------------>>>>>%@",status);
            StatusViewModel *viewModel = [[StatusViewModel alloc] init:status];
            [arrayM addObject:viewModel];
        }
//        if (since_id > 0) {
//            NSArray *array = [self.statusList arrayByAddingObjectsFromArray:arrayM];
//            self.statusList = array;
//        }else {
//            NSArray *array = [arrayM arrayByAddingObjectsFromArray:self.statusList];
//            self.statusList = array;
//        }
        self.statusList = arrayM;
        NSLog(@"22222222%@",self.statusList);
        finished(YES);
    }];
}
@end
