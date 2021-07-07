//
//  DetailViewController.m
//  testapp
//
//  Created by lichun on 2021/7/5.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>
@interface DetailViewController ()<WKNavigationDelegate>

@property(nonatomic, strong, readwrite) WKWebView *webView;

// 进度条
@property(nonatomic, strong, readwrite) UIProgressView *progressView;

@end

@implementation DetailViewController

//移除监听
- (void) dealloc {
	[self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.

	[self.view addSubview:({
		self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88)];
		self.webView.navigationDelegate = self;
		self.webView;
	})];

	[self.view addSubview:({
		self.progressView= [[UIProgressView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 40)];
		self.progressView;
	})];

	[self.webView loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString: @"https://time.geekbang.org/course/detail/100025901-95615?utm_term=zeusPGH8Q%5Cx26amp%3Butm_source%3Dwechat%5Cx26amp%3Butm_medium%3Dqianduanzhidian%5Cx26amp%3Butm_campaign%3D169-presell%5Cx26amp%3Butm_content%3Darticle"]]];
	[self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

//监听回调
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
	self.progressView.progress = self.webView.estimatedProgress;
}

@end
