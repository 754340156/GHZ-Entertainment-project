//
//  GHZLiveWebViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLiveWebViewController.h"
#import <NJKWebViewProgress/NJKWebViewProgress.h>
#import <NJKWebViewProgress/NJKWebViewProgressView.h>
@interface GHZLiveWebViewController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *currentWebView;
/**  进度条类 */
@property (nonatomic,strong) NJKWebViewProgress *progressProxy;
/**  进度条 */
@property (nonatomic,strong) NJKWebViewProgressView *progressView;
@end

@implementation GHZLiveWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.currentWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.currentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    [self.view addSubview:self.currentWebView];
    self.progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    self.currentWebView.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;

    CGRect navBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0,navBounds.size.height - 2,navBounds.size.width,2);
    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.progressView setProgress:0 animated:YES];
    [self.navigationController.navigationBar addSubview:self.progressView];
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
    self.title = [self.currentWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)dealloc
{
    [self.progressView removeFromSuperview];
}
@end
