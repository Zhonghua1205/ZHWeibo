//
//  StatusViewModel.h
//  Weibo
//
//  Created by 卢中华 on 2016/11/9.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBStatus.h"

@interface StatusViewModel : NSObject
@property (nonatomic, strong) WBStatus *status;
@property (nonatomic, strong) NSURL *iconUrl;
@property (nonatomic, strong) UIImage *iconDefalutImage;
@property (nonatomic, strong) UIImage *vipImage;
@property (nonatomic, strong) NSArray *thumbnailUrls;

- (instancetype)init: (WBStatus *)status;
@end
