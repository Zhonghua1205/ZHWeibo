//
//  HomeViewController.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/8.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "HomeViewController.h"
#import "StatusCell.h"
#import "WBStatus.h"
#import "UserAccountViewModel.h"
#import "StatusViewModel.h"
#import "StatusesListViewModel.h"
#import "WBRefreshControl.h"
// 可重用标识符
static NSString *statusCellId = @"statusCellId";
@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
// 微博数据列表模型
@property (nonatomic, strong) StatusesListViewModel *statusListViewModel;
// 上拉刷新视图
@property (nonatomic, strong) UIActivityIndicatorView *pullUpView;

@end

@implementation HomeViewController
// 微博数据列表模型 - 懒加载
- (StatusesListViewModel *)statusListViewModel {
    if (_statusListViewModel == nil) {
        _statusListViewModel = [StatusesListViewModel sharedListViewModel];
    }
    return _statusListViewModel;
}

- (UIActivityIndicatorView *)pullUpView {
    if (_pullUpView == nil) {
        _pullUpView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _pullUpView.color = [UIColor lightGrayColor];
        _pullUpView.hidden = NO;
    }
    return _pullUpView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForTableView];
    [self loadData];
}
// 准备 tableView
- (void)prepareForTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:StatusCell.self forCellReuseIdentifier:statusCellId];
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.refreshControl = [[WBRefreshControl alloc] init];
    [self.tableView.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.tableView.tableFooterView = self.pullUpView;
}

// 加载网络数据
- (void)loadData {
    // 开启刷新控件
    [self.tableView.refreshControl beginRefreshing];
    
    [self.statusListViewModel loadStatusIsPullUp:self.pullUpView.isAnimating finished:^(BOOL isSuccessed) {
        // 关闭刷新控件
        [self.tableView.refreshControl endRefreshing];
        [self.pullUpView stopAnimating];
        if (!isSuccessed) {
            NSLog(@"数据加载失败");
            return ;
        }
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Table view data source

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusListViewModel.statusList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:statusCellId forIndexPath:indexPath];
    // 设置数据
    cell.viewModel = self.statusListViewModel.statusList[indexPath.row];
//    if ((indexPath.row == self.statusListViewModel.statusList.count - 1) && !self.pullUpView.isAnimating) {
//        [self.pullUpView startAnimating];
//        [self loadData];
//    }
    NSLog(@"status id ==========|||||| %d", cell.viewModel.status.id);
    NSLog(@"user id ==========|||||| %d", cell.viewModel.status.user.id);
    
//    int n = [cell.viewModel.status.idstr doubleValue];
//    NSLog(@"nnnnnn---------|||||||||%d", n);
    
    
    return cell;
}
@end
