//
//  WBRefreshControl.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/11.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "WBRefreshControl.h"
// 刷新控件偏移标记
static CGFloat refreshOffset = -60;
@interface WBRefreshControl ()
// 刷新视图
@property (nonatomic, strong) UIView *refreshView;
// 旋转图片
@property (nonatomic, strong) UIImageView *circleView;
// 正在刷新提示
@property (nonatomic, strong) UILabel *refreshingLabel;
// 箭头视图
@property (nonatomic, strong) UIView *tipView;
// 箭头图片
@property (nonatomic, strong) UIImageView *tip;
// 准备刷新提示
@property (nonatomic, strong) UILabel *prepareRefreshLabel;
// 刷新标记
@property (nonatomic, assign, getter=isChangeFlag) BOOL changeFlag;
@end

@implementation WBRefreshControl
// 开始刷新时调用
- (void)beginRefreshing {
    [super beginRefreshing];
    [self startRefreshingRotation];
}
// 结束刷新时调用
- (void)endRefreshing {
    [super endRefreshing];
    [self stopRefreshingRotation];
}
// 重写 changeFlag 的 setter 方法
- (void)setChangeFlag:(BOOL)changeFlag {
    _changeFlag = changeFlag;
    // 加载箭头旋转动画
    [self tipRotation];
}
// KVO 监听属性变化方法
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    
    if (self.frame.origin.y > 0) {
        return;
    }
    if (self.isRefreshing) {
        // 开始旋转动画
        [self startRefreshingRotation];
        return;
    }
    if (self.frame.origin.y < refreshOffset && !self.changeFlag) {
        self.changeFlag = YES;
    }else if (self.frame.origin.y >= refreshOffset && self.changeFlag) {
        self.changeFlag = NO;
    }
}
// 箭头翻转动画
- (void)tipRotation {
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat angle = M_PI;
        self.tip.transform = CGAffineTransformRotate(self.tip.transform, angle);
    }];
}
// 开始刷新动画
- (void)startRefreshingRotation {
    NSString *key = @"refreshingRotation";
    if ([self.circleView.layer animationForKey:key]) {
        return;
    }
    self.tipView.hidden = YES;
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anim.toValue = [NSNumber numberWithFloat:2 * M_PI];
    anim.duration = 0.5;
    anim.repeatCount = MAXFLOAT;
    [self.circleView.layer addAnimation:anim forKey:key];
}
// 停止刷新动画
- (void)stopRefreshingRotation {
    self.tipView.hidden = NO;
    [self.circleView.layer removeAllAnimations];
}


// 正在刷新视图 - 懒加载
- (UIView *)refreshView {
    if (_refreshView == nil) {
        _refreshView = [[UIView alloc] init];
        _refreshView.backgroundColor = [UIColor whiteColor];
    }
    return _refreshView;
}
// 旋转图片 view - 懒加载
- (UIImageView *)circleView {
    if (_circleView == nil) {
        _circleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_loading"]];
        [_circleView sizeToFit];
    }
    return _circleView;
}
// 刷新提示 label - 懒加载
- (UILabel *)refreshingLabel {
    if (_refreshingLabel == nil) {
        _refreshingLabel = [[UILabel alloc] initWithTitle:@"正在刷新数据" textFont:14 screenOffSet:0];
    }
    return _refreshingLabel;
}
// 下拉刷新视图 - 懒加载
- (UIView *)tipView {
    if (_tipView == nil) {
        _tipView = [[UIView alloc] init];
        _tipView.backgroundColor = [UIColor whiteColor];
    }
    return _tipView;
}
// 箭头指示 view - 懒加载
- (UIImageView *)tip {
    if (_tip == nil) {
        _tip = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_pull_refresh"]];
        [_tip sizeToFit];
    }
    return _tip;
}
// 下拉刷新提示 label - 懒加载
- (UILabel *)prepareRefreshLabel {
    if (_prepareRefreshLabel == nil) {
        _prepareRefreshLabel = [[UILabel alloc] initWithTitle:@"下拉刷新数据" textFont:14 screenOffSet:0];
    }
    return _prepareRefreshLabel;
}
// 构造函数
- (instancetype)init {
    if (self == [super init]) {
        [self setupUI];
    }
    return self;
}
// 设置 UI
- (void)setupUI {
    // 旋转刷新视图
    // 添加控件
    [self addSubview:self.refreshView];
    [self.refreshView addSubview:self.circleView];
    [self.refreshView addSubview:self.refreshingLabel];
    // 设置布局
    [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.refreshView);
        make.leftMargin.mas_equalTo(100);
    }];
    [self.refreshingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.circleView.mas_right).with.offset(statusCellMargin);
        make.centerY.mas_equalTo(self.circleView);
    }];
    // 箭头视图
    // 添加控件
    [self addSubview:self.tipView];
    [self.tipView addSubview:self.tip];
    [self.tipView addSubview:self.prepareRefreshLabel];
    // 设置布局
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    [self.tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.refreshView);
        make.leftMargin.mas_equalTo(100);
    }];
    [self.prepareRefreshLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.circleView.mas_right).with.offset(statusCellMargin);
        make.centerY.mas_equalTo(self.circleView);
    }];
    // 初始化翻转标记
    self.changeFlag = YES;
    // 主队列异步添加 KVO 监听
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addObserver:self forKeyPath:@"frame" options:0 context:nil];
    });
}
- (void)dealloc {
    // 移除 KVO 监听方法
    [self removeObserver:self forKeyPath:@"frame"];
}
@end
