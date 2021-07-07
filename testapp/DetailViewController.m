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

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString: @"https://time.geekbang.org/course/detail/100025901-95615?utm_term=zeusPGH8Q%5Cx26amp%3Butm_source%3Dwechat%5Cx26amp%3Butm_medium%3Dqianduanzhidian%5Cx26amp%3Butm_campaign%3D169-presell%5Cx26amp%3Butm_content%3Darticle"]]];
}


@end
