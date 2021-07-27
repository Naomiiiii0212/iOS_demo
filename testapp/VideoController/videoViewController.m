//
//  videoViewController.m
//  testapp
//
//  Created by lichun on 2021/6/30.
//

#import "RecommendViewController.h"
#import "CollectionWaterfallLayout.h"
#import "videoViewController.h"
#import "VideoPlayer.h"
#import "VideoCoverView.h"


#define StatusBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height)
#define NavigationBarHeight (self.navigationController.navigationBar.frame.size.height)
#define TabBarHeight (self.tabBarController.tabBar.frame.size.height)

#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)

#define NavigationBarHeight 44.0
#define TabbarHeight 49.5
#define SafeAreaHeight [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom

static NSString *const kCollectionViewItemReusableID = @"kCollectionViewItemReusableID";
static NSString *const kCollectionViewHeaderReusableID = @"kCollectionViewHeaderReusableID";


@interface videoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, CollectionWaterfallLayoutProtocol>

@property (nonatomic, strong, readwrite) UICollectionView *collectionView;
@property (nonatomic, strong, readwrite) CollectionWaterfallLayout *waterfallLayout;
@property (nonatomic, strong, readwrite) NSMutableArray *dataList;
@property (nonatomic, strong, readwrite) videoViewController *videoView;

@end

@implementation videoViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"视频";

    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _collectionView.pagingEnabled = YES;
    //_collectionView.automaticallyAdjustsScrollIndicatorInsets = NO;
    
    [self setupDataList];
    [self setupRightButton];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源
- (void)setupDataList
{
    // 如果想要参差不齐的效果，可以加入随机
    _dataList = [NSMutableArray array];
    NSInteger dataCount = 50;
    //NSInteger dataCount = arc4random() % 25 + 50;
    for(NSInteger i = 0; i < dataCount; ++i) {
        CGFloat rowHeight = ScreenHeight-NavigationBarHeight-StatusBarHeight-44-TabbarHeight-SafeAreaHeight;
        //NSInteger rowHeight = arc4random() % 100 + 300;
        [_dataList addObject:@(rowHeight)];
    }
}

- (void)setupRightButton
{
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                       target:self action:@selector(buttonClick)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, nil];
}

- (void)buttonClick
{
    [self setupDataList];
    [self.collectionView reloadData];
    
}
#pragma mark - getter
- (UICollectionView *)collectionView
{
    if(!_collectionView){
        _waterfallLayout = [[CollectionWaterfallLayout alloc] init];
        _waterfallLayout.delegate = self;
        _waterfallLayout.columns = 1;
        _waterfallLayout.columnSpacing = 10;
        _waterfallLayout.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-StatusBarHeight-NavigationBarHeight) collectionViewLayout:_waterfallLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[VideoCoverView class] forCellWithReuseIdentifier:@"VideoCoverView"];
//        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewItemReusableID];
        UINib *headerViewNib = [UINib nibWithNibName:@"WFHeaderView" bundle:nil];
        [_collectionView registerNib:headerViewNib forSupplementaryViewOfKind:kSupplementaryViewKindHeader withReuseIdentifier:kCollectionViewHeaderReusableID];
    }
    
    
    return _collectionView;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0){
        return _dataList.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewItemReusableID forIndexPath:indexPath];
    //
    //    if(!cell) {
    //        cell = [[UICollectionViewCell alloc] init];
    //    }
    //
    //    CGFloat red = arc4random()%256/255.0;
    //    CGFloat green = arc4random()%256/255.0;
    //    CGFloat blue = arc4random()%256/255.0;
    //
    //    cell.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
        
        // 加入视频
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCoverView" forIndexPath:indexPath];
        if ([cell isKindOfClass:[VideoCoverView class]]) {
            // 视频播放
            [((VideoCoverView *) cell) layoutWithVideoCoverUrl:@"icon.bundle/cover.png" videoUrl:@"Users/lichun/Desktop/temp/ksdemo.mp4"];
            //[((VideoCoverView *) cell) layoutWithVideoCoverUrl:@"icon.bundle/img.png" videoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
        }
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:kSupplementaryViewKindHeader]){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kCollectionViewHeaderReusableID forIndexPath:indexPath];
        
        return headerView;
    }
    return nil;
}

#pragma mark - CollectionWaterfallLayoutProtocol
- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    CGFloat cellHeight = [_dataList[row] floatValue];
    return cellHeight;
}

- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0){
        return 0;
    }
    return 0;
}
@end
