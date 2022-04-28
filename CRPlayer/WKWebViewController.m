//
//  WKWebViewController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2021/11/23.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *wk_WebView;
@property (nonatomic, copy) NSString *urlStr;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

//    self.urlStr = @"http://m.chenhr.com/act/2021/xgs/sdhk";
    self.urlStr = @"http://m.buildhr.com/act/2022/zhwl/";
//    self.urlStr = @"https://www.baidu.com/";
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.preferences = [[WKPreferences alloc]init];
    config.userContentController = [[WKUserContentController alloc]init];

    //add
//    WKUserContentController* uc = [[WKUserContentController alloc] init];
//    config.userContentController = uc;
//    [uc addScriptMessageHandler:self name:@"jumpJob"];
//    [uc addScriptMessageHandler:self name:@"jumpCompany"];

    _wk_WebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88) configuration:config];
    _wk_WebView.navigationDelegate = self;
    _wk_WebView.UIDelegate = self;
    //添加此属性可触发侧滑返回上一网页与下一网页操作
    _wk_WebView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.wk_WebView];

    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"myhtml" ofType:@"html"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    //wk
    [_wk_WebView loadRequest:request];

    //进度监听
//    [_wk_WebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
//    [self.view addSubview:self.loadingProgressView];

    // Do any additional setup after loading the view.
}

#pragma mark --WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"方法名：%@", message.name);
    NSLog(@"参数：%@", message.body);

    NSDictionary *dic = message.body;

    if ([message.name isEqualToString:@"jumpJob"]) {
        NSString *jobId = @"";
        if (dic) {
            jobId = [dic valueForKey:@"job_id"];
        }

//        HRJobDetailViewController *jobVC = [[HRJobDetailViewController alloc]init];
//        jobVC.jobId = jobId;
//        [self.navigationController pushViewController:jobVC animated:YES];
    } else if ([message.name isEqualToString:@"jumpCompany"]) {
        NSString *entId = @"";
        if (entId) {
            entId = [dic valueForKey:@"ent_id"];
        }

//        HRCompanyDetailViewController *companyVC = [[HRCompanyDetailViewController alloc]init];
//        companyVC.enterprise_id = entId;
//        companyVC.isPush = YES;
//        [self.navigationController pushViewController:companyVC animated:YES];
    }
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//  if (!navigationAction.targetFrame.isMainFrame) {
//      [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
//  }
//  decisionHandler(WKNavigationActionPolicyAllow);
//}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

//页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    //导航栏配置
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError *_Nullable error) {
        NSLog(@"title__%@", title);
    }];

    [webView evaluateJavaScript:@"document.body.innerText" completionHandler:^(id _Nullable result, NSError *_Nullable error) {
        NSLog(@"error-%@", error);
//          NSLog(@"result-%@",result);
    }];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"error-%@", error);
    webView.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
