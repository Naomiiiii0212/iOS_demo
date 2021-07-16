//
//  SceneDelegate.m
//  testapp
//
//  Created by lichun on 2021/6/29.
//

#import "SceneDelegate.h"
#import "ViewController.h"
#import "videoViewController.h"
#import "RecommendViewController.h"
#import "MainViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
	// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
	// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
	// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
	UIWindowScene *windowScene = (UIWindowScene *)scene;
	self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
	self.window.frame = windowScene.coordinateSpace.bounds;

	//开源ui框架的封装 UIwindow - navigationController-tabbarcontroller-viewcontroller



	UITabBarController *tabbarController = [[UITabBarController alloc] init];

	ViewController *viewController = [[ViewController alloc] init];
    MainViewController *mainScrollView = [[MainViewController alloc] init];
    mainScrollView.tabBarItem.title = @"首页";

	//tabbar,app底部按钮,选中切换对应的uiviewcontroller
	//UIViewController *controller1 = [[UIViewController alloc] init];
	viewController.view.backgroundColor = [UIColor redColor];
	viewController.tabBarItem.title = @"新闻";

	//videoViewController *videoController = [[videoViewController alloc] init];
	RecommendViewController *recommendController = [[RecommendViewController alloc] init];


	//UIViewController *controller2 = [[UIViewController alloc] init];
	//controller2.view.backgroundColor = [UIColor yellowColor];
	//controller2.tabBarItem.title = @"同城";

//    UIViewController *controller3 = [[UIViewController alloc] init];
//    controller3.view.backgroundColor = [UIColor blueColor];
//    controller3.tabBarItem.title = @"消息";

//	UIViewController *center = [[UIViewController alloc] init];
//
//    UIButton * centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [centerButton setImage:[UIImage imageNamed:@"icon.bundle/btn_home_add_common.png"] forState:UIControlStateNormal];
//    me.tabBarItem = centerButton;
    
    UIViewController *center = [[UIViewController alloc] init];
    // 设置image时，指明图片渲染模式为AlwaysOriginal,解决设置后不显示的问题
    center.tabBarItem.image = [[UIImage imageNamed:@"icon.bundle/camera.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *me = [[UIViewController alloc] init];
    me.view.backgroundColor = [UIColor greenColor];
    me.tabBarItem.title = @"我";

	// 将四个页面的 UIViewController 加入到 UITabBarController 之中
	[tabbarController setViewControllers: @[mainScrollView, viewController, center, recommendController, me]];
    tabbarController.tabBar.backgroundColor = [UIColor blackColor];
    
	//设置self为delegate的接收者，也是实现方法的对象，使用者按需实现方法
	tabbarController.delegate = self;

	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarController];
    
    // 更改半透明黑色UINavigationBar的颜色
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [navigationController.navigationBar setTranslucent:YES];
//    [navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [navigationController.navigationBar setShadowImage:[UIImage new]];

	self.window.rootViewController = navigationController;
	[self.window makeKeyAndVisible];

}


//切换viewcontroller 切换完成自定义根据需求按需实现方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	NSLog(@"did select");
}

- (void)sceneDidDisconnect:(UIScene *)scene {
	// Called as the scene is being released by the system.
	// This occurs shortly after the scene enters the background, or when its session is discarded.
	// Release any resources associated with this scene that can be re-created the next time the scene connects.
	// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).

}


- (void)sceneDidBecomeActive:(UIScene *)scene {
	// Called when the scene has moved from an inactive state to an active state.
	// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
	// Called when the scene will move from an active state to an inactive state.
	// This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
	// Called as the scene transitions from the background to the foreground.
	// Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
	// Called as the scene transitions from the foreground to the background.
	// Use this method to save data, release shared resources, and store enough scene-specific state information
	// to restore the scene back to its current state.
}


@end
