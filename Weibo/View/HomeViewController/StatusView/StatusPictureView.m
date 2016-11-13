//
//  StatusPictureView.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/10.
//  Copyright © 2016年 卢中华. All rights reserved.
//




#import "StatusPictureView.h"
// collectionViewCell 的可重用标识符
static NSString *statusPictureViewCellId = @"statusPictureViewCellId";

// 自定义 collectionViewCell
@interface StatusPictureCell: UICollectionViewCell
// 显示图片的 view
@property (nonatomic, strong) UIImageView *pictureView;
// 显示图片的 URL
@property (nonatomic, strong) NSURL *imageUrl;

@end

@implementation StatusPictureCell
// 显示图片的 view - 懒加载
- (UIImageView *)pictureView {
    if (_pictureView == nil) {
        _pictureView = [[UIImageView alloc] init];
    }
    return _pictureView;
}
// 重写 imageUrl 的 setter 方法
- (void)setImageUrl:(NSURL *)imageUrl {
    _imageUrl = imageUrl;
    // 设置图片 - 网络异步加载图片
    [self.pictureView sd_setImageWithURL:self.imageUrl placeholderImage:nil];
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
    [self.contentView addSubview:self.pictureView];
    // 设置布局
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
    }];
}

@end

// 微博配图视图
@interface StatusPictureView () <UICollectionViewDataSource>

@end

@implementation StatusPictureView
// 重写 viewModel 的 setter 方法
- (void)setViewModel:(StatusViewModel *)viewModel {
    _viewModel = viewModel;
    [self reloadData];
}
// MARK: 构造函数
- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = statusPictureInMargin;
    layout.minimumInteritemSpacing = statusPictureInMargin;
    layout.itemSize = CGSizeMake(105, 105);
    layout.sectionInset = UIEdgeInsetsMake(statusPictureOutMargin, statusPictureOutMargin, statusPictureOutMargin, statusPictureOutMargin);
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    
    self.backgroundColor = [UIColor redColor];
    self.dataSource = self;
    [self registerClass:[StatusPictureCell class] forCellWithReuseIdentifier:statusPictureViewCellId];
    return self;
}
// MARK: 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.thumbnailUrls.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StatusPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:statusPictureViewCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.imageUrl = self.viewModel.thumbnailUrls[indexPath.item];
    return cell;
}

@end
