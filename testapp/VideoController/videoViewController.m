//
//  videoViewController.m
//  testapp
//
//  Created by lichun on 2021/6/30.
//

#import "videoViewController.h"
#import "VideoCoverView.h"
#import "RecommendViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavigationBarHeight 44.0
#define kTabbarHeight 49.5
#define kSafeAreaHeight [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom

@interface videoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation videoViewController


- (instancetype) init {
	self = [super init];
	if (self) {
		self.tabBarItem.title = @"视频";

	}
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	//UICollectionViewCell *collectcell = [[UICollectionViewCell alloc] init];
	self.view.backgroundColor = [UIColor whiteColor];


	//系统提供默认的流式布局
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.minimumLineSpacing = 0;
//	// 每个cell视频源占满整个屏幕，上下滑动切换cell，因此每滑动两个cell就会进行cell复用
//	 flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);

	UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabbarHeight-kSafeAreaHeight) collectionViewLayout:flowLayout];
	collectionView.dataSource = self;
	collectionView.delegate = self;
	// 必须先注册 Cell 类型⽤于重用
	// VideoCoverView替换
	[collectionView registerClass:[VideoCoverView class] forCellWithReuseIdentifier:@"VideoCoverView"];
    collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    // 视频翻页
	collectionView.pagingEnabled = YES;
    
	[self.view addSubview:collectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 30;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCoverView" forIndexPath:indexPath];
    if ([cell isKindOfClass:[VideoCoverView class]]) {
        // 视频播放
        [((VideoCoverView *) cell) layoutWithVideoCoverUrl:@"icon.bundle/cover.png" videoUrl:@"Users/lichun/Desktop/temp/ksdemo.mp4"];
        //[((VideoCoverView *) cell) layoutWithVideoCoverUrl:@"icon.bundle/img.png" videoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    }
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth, kScreenHeight-kTabbarHeight-kSafeAreaHeight);
}


@end
