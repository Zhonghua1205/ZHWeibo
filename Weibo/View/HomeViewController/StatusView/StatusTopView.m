//
//  StatusTopView.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/8.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "StatusTopView.h"
#import "WBAccount.h"
#import "WBStatus.h"

@interface StatusTopView ()
// 头像
@property (nonatomic, strong) UIImageView *iconView;
// 用户名
@property (nonatomic, strong) UILabel *nameLabel;
// 会员
@property (nonatomic, strong) UIImageView *vipView;
// 微博来源
@property (nonatomic, strong) UILabel *resourceLabel;
// 发布时间
@property (nonatomic, strong) UILabel *sendTimeLabel;

@end

@implementation StatusTopView
// 重写 viewModel 的 setter 方法
- (void)setViewModel:(StatusViewModel *)viewModel {
    _viewModel = viewModel;
    [self.iconView sd_setImageWithURL:self.viewModel.iconUrl placeholderImage:self.viewModel.iconDefalutImage];
    self.nameLabel.text = self.viewModel.status.user.screen_name;
    self.vipView.image = self.viewModel.vipImage;
}
// 头像 - 懒加载
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        [_iconView sizeToFit];
        _iconView.layer.cornerRadius = statusIconWidth / 2;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}
// 用户名 - 懒加载
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithTitle:@"新浪微博" textFont:14 screenOffSet:0];
    }
    return _nameLabel;
}
// vip - 懒加载
- (UIImageView *)vipView {
    if (_vipView == nil) {
        _vipView = [[UIImageView alloc] init];
        [_vipView sizeToFit];
    }
    return _vipView;
}
// 微博来源 - 懒加载
- (UILabel *)resourceLabel {
    if (_resourceLabel == nil) {
        _resourceLabel = [[UILabel alloc] initWithTitle:@"中华微博" textFont:11 screenOffSet:0];
    }
    return _resourceLabel;
}
// 发布时间 - 懒加载
- (UILabel *)sendTimeLabel {
    if (_sendTimeLabel == nil) {
    _sendTimeLabel = [[UILabel alloc] initWithTitle:@"刚刚" textFont:11 screenOffSet:0];
    }
    return _sendTimeLabel;
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
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.vipView];
    [self addSubview:self.resourceLabel];
    [self addSubview:self.sendTimeLabel];
    // 自动布局
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.mas_equalTo(statusCellMargin);
        make.topMargin.mas_equalTo(statusCellMargin);
        make.width.mas_equalTo(statusIconWidth);
        make.height.mas_equalTo(statusIconWidth);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).with.offset(statusCellMargin);
        make.top.mas_equalTo(self.iconView.mas_top);
    }];
    [self.vipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(statusCellMargin);
        make.bottom.mas_equalTo(self.nameLabel.mas_bottom);
    }];
    [self.sendTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.bottom.mas_equalTo(self.iconView.mas_bottom);
    }];
    [self.resourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sendTimeLabel.mas_right).with.offset(statusCellMargin);
        make.bottom.mas_equalTo(self.sendTimeLabel.mas_bottom);
    }];
}

@end
