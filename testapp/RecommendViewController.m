//
//  RecommendViewController.m
//  testapp
//
//  Created by lichun on 2021/7/1.
//

#import "RecommendViewController.h"

@interface RecommendViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation RecommendViewController

//重写init构造方法，必须先调用父类的init方法，返回值赋给self
- (instancetype) init {
	self = [super init];
	if (self) {

		self.tabBarItem.title = @"推荐";
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor whiteColor];
	//推荐页滚动列表
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	scrollView.backgroundColor = [UIColor grayColor];
	scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
	scrollView.delegate = self;

	//颜色数组
	NSArray *colorArray = @[[UIColor redColor], [UIColor grayColor], [UIColor grayColor], [UIColor blueColor], [UIColor yellowColor]];

	for (int i = 0; i < 5; ++i) {
		[scrollView addSubview:({
			UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width * i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];

			//添加一个小视图，实现自定义点击与手势
			[view addSubview:({
				UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
				view.backgroundColor = [UIColor yellowColor];
				UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
				tapGesture.delegate = self;
				//将手势加入view
				[view addGestureRecognizer:tapGesture];
				view;
			})];

			view.backgroundColor = [colorArray objectAtIndex:i];
			view;
		})];
	}
	//scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.pagingEnabled = YES;
	[self.view addSubview:scrollView];
}

//手势
- (void) viewClick {
	NSLog(@"viewclick");
}

//手势一开始加到整个页面，通过响应是否需要识别手势来实现更小模块等复杂的应用
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	return YES;
}


//监听页面滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

}

@end
