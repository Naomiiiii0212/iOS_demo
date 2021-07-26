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
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavigationBarHeight 44.0
#define kTabbarHeight 49.5
#define kSafeAreaHeight [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom

@interface MainViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIScrollView *mainScrollView;
@property(nonatomic, strong) UIView *slideBGView;
@property(nonatomic, strong) UIView *slideLine;
@property(nonatomic, strong) UIButton *currentSelectBtn;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewControllers];
    
    [self setupView];
    
    [self showDefaultViewWithIndex:2];
}

#pragma mark - 初始化页面
- (void)setupView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.slideBGView];
    
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.contentSize = CGSizeMake(kScreenWidth * self.childViewControllers.count, 0);
}

#pragma mark - 添加子控制器
- (void)setupChildViewControllers{
    videoViewController *vc1 = [[videoViewController alloc]init];
    [self addChildViewController:vc1];
    RecommendViewController *vc2 = [[RecommendViewController alloc] init];
    [self addChildViewController:vc2];
    videoViewController *vc3 = [[videoViewController alloc]init];
    [self addChildViewController:vc3];
}

#pragma mark - 设置第一次展示的vc
- (void)showDefaultViewWithIndex:(NSInteger)index{
    if (index < 0) {
        return;
    }
    [self.mainScrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
    [self showViewWithIndex:index];
}

#pragma mark - UIScrollViewDelegate ScrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    [self showViewWithIndex:index];
}

#pragma mark - 点击按钮
- (void)clickFunBtn:(UIButton *)btn{
    NSInteger index = btn.tag-1;
    [self showDefaultViewWithIndex:index];
}

#pragma mark - private
- (void)showViewWithIndex:(NSInteger)index{

    UIButton *btn = [self.slideBGView viewWithTag:index+1];
    if (btn == self.currentSelectBtn) {
        return;
    }
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(kScreenWidth * index, 0, self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height);
    [self.mainScrollView addSubview:vc.view];
    
    CGFloat w = kScreenWidth / self.childViewControllers.count;
    [UIView animateWithDuration:0.25 animations:^{
        self.slideLine.frame = CGRectMake(w * index + 0.2 * w, 40, 0.6 * w, 4);
    }];
    
    self.currentSelectBtn.selected = NO;
    btn.selected = YES;
    self.currentSelectBtn = btn;
}

#pragma mark- getter & setter
- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight + kStatusBarHeight + 44, kScreenWidth, kScreenHeight-kNavigationBarHeight-kStatusBarHeight-44-kTabbarHeight-kSafeAreaHeight)];
        _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _mainScrollView.delegate = self;
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}

- (UIView *)slideBGView{
    if (_slideBGView == nil) {
        _slideBGView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kScreenWidth, 44)];
        _slideBGView.backgroundColor = [UIColor whiteColor];
        
        CGFloat w = kScreenWidth / self.childViewControllers.count;
        for (int i = 0; i < self.childViewControllers.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(w * i, 0, w, 44);
            btn.tag = i + 1;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
            [btn setTitle:[NSString stringWithFormat:@"%i",i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickFunBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_slideBGView addSubview:btn];
        }
        self.slideLine.tag = self.childViewControllers.count;
        [_slideBGView addSubview:self.slideLine];
    }
    return _slideBGView;
}

- (UIView *)slideLine{
    if (_slideLine == nil) {
        _slideLine = [[UIView alloc] init];
        _slideLine.backgroundColor = [UIColor redColor];
    }
    return _slideLine;
}

@end
