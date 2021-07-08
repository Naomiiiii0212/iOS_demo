//
//  ViewController.m
//  testapp
//
//  Created by lichun on 2021/6/29.
//

#import "ViewController.h"
#import "NormalTableViewCell.h"
#import "DetailViewController.h"
#import "DeleteCellView.h"
#import "ListLoader.h"
#import "ListItem.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource, NormalTableViewCellDelegate>
@property(nonatomic, strong, readwrite) UITableView *tableview;
@property(nonatomic, strong, readwrite) NSArray *dataArray;
@property(nonatomic, strong, readwrite) ListLoader *listLoader;

@end

@implementation ViewController

- (instancetype) init {
	self = [super init];
	if (self) {

	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor whiteColor];

	_tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
	_tableview.dataSource = self;
	_tableview.delegate = self;

	[self.view addSubview:_tableview];

	self.listLoader = [[ListLoader alloc] init];

	__weak typeof(self) wself = self;
	[self.listLoader loadListDatawitjFinishBlock:^(BOOL success, NSArray<ListItem *> * _Nonnull dataArray) {
	         __strong typeof(wself) strongSelf = wself;
	         strongSelf.dataArray = dataArray;
	         [strongSelf.tableview reloadData];
	 }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}
//使用WKWebView实现简单的页面加载
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    DetailViewController *controller = [[DetailViewController alloc] initWithUrlString:item.articleUrl];
	controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
	[self.navigationController pushViewController:controller animated:YES];
}

//UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _dataArray.count;
}

//系统提供复⽤用回收池，根据 reuseIdentifier 作为标识
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];

	if (!cell) {
		cell = [[NormalTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"id"];
		cell.delegate = self;
	}

	[cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];

	return cell;
}


- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
//	DeleteCellView *deleteView = [[DeleteCellView alloc] initWithFrame:self.view.bounds];
//
//	CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
//
//	//block处理循环引用问题
//	__weak typeof(self) wself = self;
//	//删除点击的cell动画
//	[deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
//	         __strong typeof(wself) strongSelf = wself;
//	         //数量删除
//	         //[strongSelf.dataArray removeLastObject];
//	         [strongSelf.tableview deleteRowsAtIndexPaths:@[[strongSelf.tableview indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
//	 }];
}



@end
