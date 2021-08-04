//
//  MainTabBarViewController.m
//  testapp
//
//  Created by zhangpeijin on 2021/7/26.
//

#import "MainTabBarViewController.h"
#import "ViewController.h"
#import "videoViewController.h"
#import "RecommendViewController.h"
#import "MainViewController.h"
#import "meViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewControllers];
}

#pragma mark - 初始化子控制器
- (void)setupChildViewControllers {
    MainViewController *vc1 = [[MainViewController alloc] init];
    //UINavigationController *naVC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    vc1.tabBarItem.title = @"首页";
    [self addChildViewController:vc1];
    
    ViewController *vc2 = [[ViewController alloc] init];
    UINavigationController *naVC2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    naVC2.tabBarItem.title = @"新闻";
    [self addChildViewController:naVC2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    //UINavigationController *naVC3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    vc3.tabBarItem.image = [[UIImage imageNamed:@"icon.bundle/camera.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:vc3];
    
    RecommendViewController *vc4 = [[RecommendViewController alloc] init];
    UINavigationController *naVC4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    naVC4.tabBarItem.title = @"推荐";
    [self addChildViewController:naVC4];
    
    meViewController *vc5 = [[meViewController alloc] init];
    //UINavigationController *naVC5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    vc5.tabBarItem.title = @"我";
    [self addChildViewController:vc5];
}

@end
