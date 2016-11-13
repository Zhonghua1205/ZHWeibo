//
//  WBTabBarController.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/8.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "WBTabBarController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ComposedViewController.h"
#import "DiscoveryViewController.h"
#import "ProfileViewController.h"

@interface WBTabBarController ()
// 加号按钮
@property (nonatomic, strong) UIButton *composedBtn;

@end

@implementation WBTabBarController
// 懒加载
- (UIButton *)composedBtn {
    if (_composedBtn == nil) {
        _composedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_composedBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_composedBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [_composedBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_composedBtn setBackgroundImage:[UIImage imageNamed: @"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    }
    return _composedBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllControllers];
    [self addComposedButton];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBar.tintColor = [UIColor orangeColor];
    [self.tabBar bringSubviewToFront:self.composedBtn];
}
// 添加加号按钮
- (void)addComposedButton {
     [self.tabBar addSubview:self.composedBtn];
    CGFloat w = self.tabBar.bounds.size.width / self.childViewControllers.count - 1;
    self.composedBtn.frame = CGRectMake(2 * w, 0, w, self.tabBar.bounds.size.height);
}
// 添加子控制器
- (void)addAllControllers {
    [self addSingleControllerWithViewController:[[HomeViewController alloc] init] Title:@"首页" ImageName:@"tabbar_home"];
    [self addSingleControllerWithViewController:[MessageViewController new] Title:@"消息" ImageName:@"tabbar_message_center"];
    [self addChildViewController:[UIViewController new]];
    [self addSingleControllerWithViewController:[DiscoveryViewController new] Title:@"发现" ImageName:@"tabbar_discover"];
    [self addSingleControllerWithViewController:[ProfileViewController new] Title:@"我的" ImageName:@"tabbar_profile"];
}
// 添加单个控制器
- (void)addSingleControllerWithViewController: (UIViewController *)vc Title: (NSString *)title ImageName: (NSString *)imageName {
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    [vc.view setBackgroundColor:[UIColor whiteColor]];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end
