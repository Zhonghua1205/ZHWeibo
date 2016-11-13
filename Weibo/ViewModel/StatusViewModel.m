//
//  StatusViewModel.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/9.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "StatusViewModel.h"


@implementation StatusViewModel
- (instancetype)init: (WBStatus *)status {
    self.status = status;
    if (status.pic_urls.count > 0) {
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.thumbnailUrls.count];
        for (NSDictionary *dict in status.pic_urls) {
            NSURL *url = [NSURL URLWithString:dict[@"thumbnail_pic"]];
            [arrayM addObject:url];
        }
        self.thumbnailUrls = arrayM;
    }
    return self;
}
- (NSURL *)iconUrl {
    if (_iconUrl == nil) {
        _iconUrl = [NSURL URLWithString:self.status.user.profile_image_url];
    }
    return _iconUrl;
}
- (UIImage *)iconDefalutImage {
    if (_iconDefalutImage == nil) {
        _iconDefalutImage = [UIImage imageNamed:@"avatar_default_big"];
    }
    return _iconDefalutImage;
}
- (UIImage *)vipImage {
    if (_vipImage == nil) {
        if (self.status.user.mbrank > 0 && self.status.user.mbrank < 7 ) {
            NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",self.status.user.mbrank];
            _vipImage = [UIImage imageNamed:vipName];
        }
    }
    return _vipImage;
}

- (NSArray *)thumbnailUrls {
    if (_thumbnailUrls == nil) {
        _thumbnailUrls = [NSArray array];
    }
    return _thumbnailUrls;
}

@end
