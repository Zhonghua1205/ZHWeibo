//
//  StatusBottomView.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/10.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "StatusBottomView.h"

@interface StatusBottomView ()
// 评论
@property (nonatomic, strong) UIButton *commentBtn;
// 转发
@property (nonatomic, strong) UIButton *retweedBtn;
// 赞
@property (nonatomic, strong) UIButton *like;

@end

@implementation StatusBottomView
// 评论 - 懒加载
- (UIButton *)commentBtn {
    if (_commentBtn == nil) {
        _commentBtn = [[UIButton alloc] initWithTitle:@"评论" TextFont:12 ImageName:@"timeline_icon_comment"];
    }
    return _commentBtn;
}
// 转发 - 懒加载
- (UIButton *)retweedBtn {
    if (_retweedBtn == nil) {
        _retweedBtn = [[UIButton alloc] initWithTitle:@"转发" TextFont:12 ImageName:@"timeline_icon_retweet"];
    }
    return _retweedBtn;
}
// 赞 - 懒加载
- (UIButton *)like {
    if (_like == nil) {
        _like = [[UIButton alloc] initWithTitle:@"赞" TextFont:12 ImageName:@"timeline_icon_unlike"];
    }
    return _like;
}
// 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
// 设置 UI
- (void)setupUI {
    // 添加控件
    [self addSubview:self.retweedBtn];
    [self addSubview:self.commentBtn];
    [self addSubview:self.like];
    // 设置布局
    [self.retweedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.topMargin.mas_equalTo(statusCellMargin);
        make.bottomMargin.mas_equalTo(-statusCellMargin);
    }];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.retweedBtn.mas_right);
        make.top.mas_equalTo(self.retweedBtn);
        make.bottom.mas_equalTo(self.retweedBtn);
        make.width.mas_equalTo(self.retweedBtn);
    }];
    [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentBtn.mas_right);
        make.top.mas_equalTo(self.commentBtn);
        make.bottom.mas_equalTo(self.commentBtn);
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(self.commentBtn);
    }];
}

@end
