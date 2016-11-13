//
//  OAuthViewController.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/7.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "OAuthViewController.h"
#import "WBAccount.h"
#import "WBStatus.h"

@interface OAuthViewController () <UIWebViewDelegate>
// 加载OAuth 授权登录页面
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForWebView];
    [self prepareForNavgationBar];
}
//  设置导航栏按钮
- (void)prepareForNavgationBar {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closed:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"自动填充" style:UIBarButtonItemStylePlain target:self action:@selector(autoFill)];
}
// 设置 webView
- (void)prepareForWebView {
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = self.view.bounds;
    [self.view addSubview: self.webView];
    self.webView.delegate = self;
    // 加载授权登录页面
    [self.webView loadRequest:[NSURLRequest requestWithURL:[[WBNetworkingTools sharedTools] loadOauthURL]]];
}
// webView 的代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 获取 code
//    NSLog(@"request-----------%@",request.URL);
    NSURL *url = request.URL;
    if (![url.host  isEqual: @"www.baidu.com"]) {
        return YES;
    }
    NSString *query = url.query;
    if (![query hasPrefix:@"code="]) {
        NSLog(@"取消授权");
        return NO;
    }
    NSString *code = [query substringFromIndex: 5];
    // 利用 code 来获取 token 并加载用户信息
    [[WBNetworkingTools sharedTools] loadAccess_tokenWithCode:code finished:^(id responseObject, NSError *error) {
        if (error != nil) {
            return ;
        }
        NSDictionary *reslut = responseObject;
        WBAccount *account = [WBAccount accountWithDict:reslut];
        // 加载用户信息
        [self loadAccountInfoWithAccount:account];
    }];
    return NO;
}
// 加载用户信息
- (void)loadAccountInfoWithAccount: (WBAccount *)account {
    // 加载用户信息
    [[WBNetworkingTools sharedTools] loadAccountInfoWithToken:account.access_token uid:account.uid finished:^(id responseObject, NSError *error) {
        if (error != nil) {
            NSLog(@"加载账户信息失败");
            return ;
        }
        NSDictionary *reslut = responseObject;
        if (reslut[@"screen_name"]) {
            account.screen_name = reslut[@"screen_name"];
        }
        if (reslut[@"avatar_large"]) {
            account.avatar_large = reslut[@"avatar_large"];
        }
        [account saveAccountInfoWithAccount:account];
    }];
}
// 关闭当前控制器
- (void)closed: (UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 自动填充账号密码
- (void)autoFill {
    NSString *jsM = @"document.getElementById('userId').value = '498448441@qq.com';";
    NSString *js = [jsM stringByAppendingString:@"document.getElementById('passwd').value = 'luzhonghua1205';"];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}
@end
