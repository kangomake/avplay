//
//  WebViewController.m
//  hr_renzheng
//
//  Created by appleDeveloper on 2021/4/20.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *loadingProgressView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.preferences = [[WKPreferences alloc] init];
    config.userContentController = [[WKUserContentController alloc]init];
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:_loadingProgressView];
    
    
    [self loadHtml];
    
    // Do any additional setup after loading the view.
}

- (void)loadHtml{
    
    if(!self.urlStr){
        return;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [self.webView loadRequest:request];
    
    
}

#pragma mark -- WKNavigationDelegate

#pragma mark 加载状态回调
//页面开始加载

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    webView.hidden = NO;
    _loadingProgressView.hidden = NO;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if([webView.URL.scheme isEqual:@"about"]){
        webView.hidden = YES;
    }
    
}




//页面加载完成
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
       
        
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
    webView.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        _loadingProgressView.progress = [change[@"new"] floatValue];
        if (_loadingProgressView.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _loadingProgressView.hidden = YES;
            });
        }
    }
    
}


- (UIProgressView*)loadingProgressView {
    
    if (!_loadingProgressView) {
        _loadingProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 2)];
        _loadingProgressView.progressTintColor = [UIColor orangeColor];
        _loadingProgressView.trackTintColor = [UIColor clearColor];
    }
    return _loadingProgressView;
}

- (void)dealloc {
    
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView stopLoading];
    _webView.UIDelegate = nil;
    _webView.navigationDelegate = nil;
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
