//
//  StatusCell.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/8.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "StatusCell.h"
#import "StatusTopView.h"
#import "StatusPictureView.h"
#import "StatusBottomView.h"
#import "StatusViewModel.h"

@interface StatusCell ()
// 顶部视图
@property (nonatomic, strong) StatusTopView *topView;
// 微博正文
@property (nonatomic, strong) UILabel *textViewLabel;
// 微博图片
@property (nonatomic, strong) StatusPictureView *pictureView;
// 底部视图
@property (nonatomic, strong) StatusBottomView *bottomView;
// 配图视图大小
@property (nonatomic, assign) CGSize pictureViewSize;

@end

@implementation StatusCell
// 重写 viewModel 的 setter 方法
-(void)setViewModel:(StatusViewModel *)viewModel {
    _viewModel = viewModel;
    self.topView.viewModel = self.viewModel;
    self.textViewLabel.text = self.viewModel.status.text;
    self.pictureView.viewModel = self.viewModel;
    // 更新 配图视图的约束
    CGSize pictureViewSize = [self calculateSizeWithCount:self.viewModel.thumbnailUrls.count];
    [self.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(pictureViewSize.width);
        make.height.mas_equalTo(pictureViewSize.height);
    }];
}
// 顶部视图 - 懒加载
- (StatusTopView *)topView {
    if (_topView == nil) {
        _topView = [[StatusTopView alloc] init];
    }
    return _topView;
}
// 配图视图 - 懒加载
- (StatusPictureView *)pictureView {
    if (_pictureView == nil) {
        _pictureView = [[StatusPictureView alloc] init];
    }
    return _pictureView;
}
// 底部视图 - 懒加载
- (StatusBottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[StatusBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
    }
    return _bottomView;
}
// 微博正文 - 懒加载
- (UILabel *)textViewLabel {
    if (_textViewLabel == nil) {
        _textViewLabel = [[UILabel alloc] initWithTitle:@"微博正文" textFont:13 screenOffSet:statusCellMargin];
    }
    return _textViewLabel;
}
// 构造函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
// 设置 UI
- (void)setupUI {
    // 添加控件
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.textViewLabel];
    [self.contentView addSubview:self.pictureView];
    [self.contentView addSubview:self.bottomView];
    // 设置布局
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(statusCellMargin + statusIconWidth);
    }];
    [self.textViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).with.offset(statusCellMargin);
        make.leftMargin.mas_equalTo(statusCellMargin);
        make.right.mas_equalTo(self.contentView).with.offset(-statusCellMargin);
    }];
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textViewLabel.mas_bottom).with.offset(statusCellMargin);
        make.leftMargin.mas_equalTo(statusCellMargin);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(300);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pictureView.mas_bottom).with.offset(statusCellMargin);
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);//.with.offset(-statusCellMargin);
    }];
}
// 计算配图视图的大小
- (CGSize)calculateSizeWithCount: (NSInteger)count {
    NSInteger rowCount = 3;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 3 * statusCellMargin;
    CGFloat picWidth = (maxWidth - 2 * (statusPictureInMargin + statusPictureOutMargin)) / rowCount;
    if (count == 0) {
        return CGSizeZero;
    }
    // 1张图
    if (count == 1) {
        CGSize size = CGSizeMake(125, 125);
        return size;
    }
    // 4张图
    if (count == 4) {
        CGFloat w = 2 * picWidth + statusPictureInMargin + 2 * statusPictureOutMargin;
        CGSize size = CGSizeMake(w, w);
        return size;
    }
    // 其他
    NSInteger r = ((count - 1) / rowCount + 1);
    if (r == 1) {
        rowCount = count;
    }
    CGFloat h = r * picWidth + 2 * statusPictureOutMargin + (r - 1) * statusPictureInMargin;
    CGFloat w = rowCount * picWidth + 2 * statusPictureOutMargin + (rowCount - 1) * statusPictureInMargin;
    return CGSizeMake(w, h);
}

@end
