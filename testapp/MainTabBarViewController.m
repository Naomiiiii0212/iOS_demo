//
//  MainTabBarViewController.m
//  testapp
//
//  Created by lichun on 2021/7/26.
//

#import "MainTabBarViewController.h"
#import "ViewController.h"
#import "videoViewController.h"
#import "RecommendViewController.h"
#import "MainViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self setChildViewControllers];
}

// 初始化子控制器
- (void) setChildViewControllers {
	MainViewController *vc1 = [[MainViewController alloc] init];
	UINavigationController *mainView = [[UINavigationController alloc] initWithRootViewController:vc1];
	mainView.tabBarItem.title = @"首页";
	[self addChildViewController:mainView];

	ViewController *vc2 = [[ViewController alloc] init];
	UINavigationController *newView = [[UINavigationController alloc] initWithRootViewController:vc2];
	newView.tabBarItem.title = @"新闻";
	[self addChildViewController:newView];

	UIViewController *vc3 = [[UIViewController alloc] init];
	UINavigationController *naVC3 = [[UINavigationController alloc] initWithRootViewController:vc3];
	naVC3.tabBarItem.image = [[UIImage imageNamed:@"icon.bundle/camera.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	[self addChildViewController:naVC3];

	RecommendViewController *vc4 = [[RecommendViewController alloc] init];
	UINavigationController *recommendView = [[UINavigationController alloc] initWithRootViewController:vc4];
	recommendView.tabBarItem.title = @"推荐";
	[self addChildViewController:recommendView];

	UIViewController *vc5 = [[UIViewController alloc] init];
	UINavigationController *meView = [[UINavigationController alloc] initWithRootViewController:vc5];
	meView.tabBarItem.title = @"我";
	[self addChildViewController:meView];
}

@end
