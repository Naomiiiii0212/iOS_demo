//
//  MainViewController.m
//  testapp
//
//  Created by lichun on 2021/7/16.
//

#import "MainViewController.h"
#import "videoViewController.h"
#import "RecommendViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface MainViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIScrollView *mainScrollView;
@property (nonatomic, strong, readwrite) videoViewController *firstVc;
@property (nonatomic, strong, readwrite) videoViewController *secondVc;
@property (nonatomic, strong, readwrite) videoViewController *thirdVc;
@property (nonatomic, strong, readwrite) UIView *btnContainerView;
@property (nonatomic, strong, readwrite) UILabel *slideLabel;
@property (nonatomic, strong, readwrite) NSMutableArray *btnsArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self setMainSrollView];
}


// 整体思路：在一个控制器中放置一个UIScrollView，新建三个子控制器，并将这三个子控制器的view加入到scrollView中，在导航栏的titleView中加入三个按钮以及一个滑动的Label
-(void)setMainSrollView {
	_mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height)];
	_mainScrollView.delegate = self;
	_mainScrollView.backgroundColor = [UIColor whiteColor];
	_mainScrollView.pagingEnabled = YES;
	_mainScrollView.showsHorizontalScrollIndicator = NO;
	_mainScrollView.showsVerticalScrollIndicator = NO;
	[self.view addSubview:_mainScrollView];

	NSArray *views = @[self.firstVc.view,self.secondVc.view, self.thirdVc.view];
	for (NSInteger i = 0; i < self.btnsArray.count; ++i) {
		//把三个videoViewController的view依次贴到_mainScrollView上面
		UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height - 100)];
		[pageView addSubview:views[i]];
		[_mainScrollView addSubview:pageView];
	}
	_mainScrollView.contentSize = CGSizeMake(kScreenWidth*(views.count), 0);
}

// 通过设置contentOffset，这里的sender是被点击的按钮 通过给每一个按钮绑定一个tag来实现滚动距离的设置
-(void)sliderAction:(UIButton *)sender {
	[self sliderAnimationWithTag:sender.tag];
	[UIView animateWithDuration:0.3 animations:^{
	         _mainScrollView.contentOffset = CGPointMake(kScreenWidth*(sender.tag), 0);
	 } completion:^(BOOL finished) {

	 }];
}



-(void)sliderAnimationWithTag:(NSInteger)tag {
	[self.btnsArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
	         btn.selected = NO;
	 }];
	//获取被选中的按钮
	UIButton *selectedBtn = self.btnsArray[tag];
	selectedBtn.selected = YES;
	//动画
	[UIView animateWithDuration:0.3 animations:^{
	         _slideLabel.center = CGPointMake(selectedBtn.center.x, _slideLabel.center.y);
	 } completion:^(BOOL finished) {
	         [self.btnsArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
	                  btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
		  }];
	         selectedBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
	 }];
}


#pragma mark- 懒加载
- (videoViewController *)firstVc {
	if (!_firstVc) {
		_firstVc = [[videoViewController alloc]init];
	}
	return _firstVc;
}

- (videoViewController *)secondVc {
	if (!_secondVc) {
		_secondVc = [[videoViewController alloc]init];
	}
	return _secondVc;
}

- (videoViewController *)thirdVc {
	if (!_thirdVc) {
		_thirdVc = [[videoViewController alloc]init];
	}
	return _thirdVc;
}



- (NSMutableArray *)btnsArray {
	if (!_btnsArray) {
		_btnsArray = [NSMutableArray array];
		self.btnContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
		self.navigationItem.titleView = _btnContainerView;

		_slideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40 - 2, kScreenWidth / 3, 4)];
		_slideLabel.backgroundColor = [UIColor redColor];

		[_btnContainerView addSubview:_slideLabel];

		for (int i = 0; i < 3; ++i) {
			UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
			[btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
			[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			btn.frame = CGRectMake(i * kScreenWidth/3 - 10,0, kScreenWidth / 3, _btnContainerView.frame.size.height);
			btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
			[btn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
			[btn setTitle:[NSString stringWithFormat:@"第%d个",i] forState:UIControlStateNormal];
			btn.tag = i;
			[_btnsArray addObject:btn];
			if (i == 0) {
				btn.selected = YES;
				btn.titleLabel.font = [UIFont boldSystemFontOfSize:19];

			}
			[_btnContainerView addSubview:btn];
		}
	}
	return _btnsArray;
}


//scrollView滑动代理监听,在代理方法中通过一个tag值来让导航栏上的按钮被选中
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
	double index_ = scrollView.contentOffset.x/kScreenWidth;
	[self sliderAnimationWithTag:(int)(index_+0.5)];
}


@end
