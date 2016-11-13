//
//  VisitorView.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/8.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "VisitorView.h"
@interface VisitorView ()
// 小房子
@property (nonatomic, strong) UIImageView *midleView;
// 转动的圆环
@property (nonatomic, strong) UIImageView *roundView;
// 文字描述
@property (nonatomic, strong) UILabel *infoLabel;


@end


@implementation VisitorView
- (UIImageView *)midleView {
    if (_midleView == nil) {
        _midleView = [[UIImageView alloc] init];
        _midleView.image = [UIImage imageNamed:@"visitordiscover_feed_image_house"];
        [_midleView sizeToFit];
    }
    return _midleView;
}
- (UIImageView *)roundView {
    if (_roundView == nil) {
        _roundView = [[UIImageView alloc] init];
        _roundView.image = [UIImage imageNamed:@"visitordiscover_feed_image_smallicon"];
        [_roundView sizeToFit];
    }
    return _roundView;
}

- (UILabel *)infoLabel {
    if (_infoLabel == nil) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"关注一些人，回这里看看有什么惊喜";
        _infoLabel.preferredMaxLayoutWidth = 280;
        [_infoLabel sizeToFit];
        _infoLabel.textColor = [UIColor darkGrayColor];
        _infoLabel.numberOfLines = 0;
    }
    return _infoLabel;
}
- (UIButton *)registerButton {
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_registerButton setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateNormal];
    }
    return _registerButton;
}
- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateNormal];
    }
    return _loginButton;
}
- (void)startAnim {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anim.toValue = [NSNumber numberWithDouble:2 * M_PI];
//    anim.toValue = M_PI;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 5;
    [anim setRemovedOnCompletion:NO];
    [self.roundView.layer addAnimation:anim forKey:nil];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self startAnim];
    }
    return self;
}

- (void)setupUI {
    // 添加控件
    [self addSubview:self.midleView];
    [self addSubview:self.roundView];
    [self addSubview:self.infoLabel];
    [self addSubview:self.registerButton];
    [self addSubview:self.loginButton];
    // 设置布局
    [self.midleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(-40);
    }];
    [self.roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.midleView);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.roundView.mas_bottom).with.offset(16);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoLabel.mas_bottom).with.offset(16);
        make.left.mas_equalTo(self.infoLabel.mas_left);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoLabel.mas_bottom).with.offset(16);
        make.right.mas_equalTo(self.infoLabel.mas_right);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
}
@end
