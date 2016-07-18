//
//  GHZLiveWebViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLiveWebViewController.h"
#import <WebKit/WebKit.h>
@interface GHZLiveWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong)WKWebView *currentWebView;

@end

@implementation GHZLiveWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.currentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    [self.view addSubview:self.currentWebView];
    self.currentWebView.navigationDelegate=self;
    self.currentWebView.UIDelegate=self;
}

#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated:
            break;
        case WKNavigationTypeFormSubmitted:
            break;
        case WKNavigationTypeBackForward:
            break;
        case WKNavigationTypeReload:
            break;
        case WKNavigationTypeFormResubmitted:
            break;
        default:
            break;
    }
    //host
    NSLog(@"%@",navigationAction.sourceFrame.securityOrigin.host);
    NSLog(@"%@",navigationAction.targetFrame.securityOrigin.host);
    ///捕获异常
    //第一用的时候不会用，程序直接崩溃了，有点类似于UIWebVew返回Bool那个方法
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
}
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView   didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
}



@end
