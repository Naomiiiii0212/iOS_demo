//
//  RecommendViewController.m
//  testapp
//
//  Created by lichun on 2021/7/1.
//

#import "RecommendViewController.h"
#import "CollectionWaterfallLayout.h"
#import "videoViewController.h"
#import "VideoPlayer.h"
#import "VideoCoverView.h"

#define kStatusBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height)
#define kNavigationBarHeight (self.navigationController.navigationBar.frame.size.height)
#define kTabBarHeight (self.tabBarController.tabBar.frame.size.height)
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)

@interface RecommendViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, CollectionWaterfallLayoutProtocol>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) videoViewController *videoView;

@end

@implementation RecommendViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupDataList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源
- (void)setupDataList {
    // 如果想要参差不齐的效果，可以加入随机
    _dataList = [NSMutableArray array];
    NSInteger dataCount = 50;
    // NSInteger dataCount = arc4random() % 25 + 50;
    for(NSInteger i = 0; i < dataCount; ++i) {
        CGFloat rowHeight = 300;
        // NSInteger rowHeight = arc4random() % 100 + 300;
        [_dataList addObject: @(rowHeight)];
    }
}

- (void)buttonClick {
    [self setupDataList];
    [self.collectionView reloadData];
    
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _waterfallLayout = [[CollectionWaterfallLayout alloc] init];
        _waterfallLayout.delegate = self;
        _waterfallLayout.columns = 2;
        _waterfallLayout.columnSpacing = 10;
        _waterfallLayout.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStatusBarHeight-kNavigationBarHeight) collectionViewLayout:_waterfallLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[VideoCoverView class] forCellWithReuseIdentifier:@"VideoCoverView"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0) {
        return _dataList.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        // 加入视频
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCoverView" forIndexPath:indexPath];
        if ([cell isKindOfClass:[VideoCoverView class]]) {
            // 视频播放
            [((VideoCoverView *) cell) layoutWithVideoCoverUrl:@"icon.bundle/cover.png" videoUrl:@"Users/lichun/Desktop/temp/ksdemo.mp4"];
            //[((VideoCoverView *) cell) layoutWithVideoCoverUrl:@"icon.bundle/img.png" videoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
        }
    return cell;
}

#pragma mark - CollectionWaterfallLayoutProtocol
- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    CGFloat cellHeight = [_dataList[row] floatValue];
    return cellHeight;
}

- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 0;
    }
    return 0;
}

@end
