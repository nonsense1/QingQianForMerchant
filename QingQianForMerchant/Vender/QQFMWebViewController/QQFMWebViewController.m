//
//  QQFMWebViewController.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/23.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "QQFMWebViewController.h"

@interface QQFMWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) NSUInteger loadCount;

@end

@implementation QQFMWebViewController

- (void)dealloc {
    [self.webView stopLoading];
    self.webView.navigationDelegate = nil;
    self.webView.UIDelegate = nil;
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)initWithAddress:(NSString *)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithURL:(NSURL *)URL {
    return [self initWithURLRequest:[NSURLRequest requestWithURL:URL]];
}

- (instancetype)initWithURLRequest:(NSURLRequest *)request {
    if (self = [super init]) {
        self.request = request;
    }
    return self;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}


- (void)loadRequest:(NSURLRequest *)request {
    [self.webView loadRequest:request];
}

- (void)loadView {
    self.view = self.webView;
    [self loadRequest:self.request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithBtnTitle:@"返回" target:self action:@selector(dismissSelf)];
    [self layoutUI];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)dismissSelf {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)layoutUI {
    self.progressView = ({
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
        progressView.tintColor = [UIColor colorWithHexString:@"0xf61d4a" andAlpha:0.8];
        progressView.trackTintColor = [UIColor whiteColor];
        [self.view addSubview:progressView];
        progressView;
    });
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newProgress ==1) {
            _progressView.hidden = YES;
            [_progressView setProgress:0];
        }else{
            _progressView.hidden = NO;
            [_progressView setProgress:newProgress];
        }
    }
}

#pragma mark -WKWebViewDelegate

- (void)setLoadCount:(NSUInteger)loadCount {
    _loadCount = loadCount;
    if (loadCount == 0) {
        _progressView.hidden = YES;
        [_progressView setProgress:0];
    }else{
        _progressView.hidden = NO;
        CGFloat old = _progressView.progress;
        CGFloat new = (1.0 - old) / (loadCount + 1) + old;
        if (new > 0.95) {
            new = 0.95;
        }
        [_progressView setProgress:new];
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    self.loadCount ++;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    self.loadCount --;
    
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id data, NSError * _Nullable error) {
      self.title = data;
    }];
}


@end
