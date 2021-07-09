//
//  ListLoader.m
//  testapp
//
//  Created by lichun on 2021/7/7.
//

#import "ListLoader.h"
#import "AFNetworking.h"
#import "ListItem.h"

@implementation ListLoader

- (void) loadListDatawitjFinishBlock:(ListLoaderFinishBlock) finishBlock {

    NSArray<ListItem *> *listdata = [self _readDataFromLocal];
    //如果已有缓存
    if (listdata) {
        finishBlock(YES, listdata);
    }
    //网络请求
	NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
	NSURL *listUrl = [NSURL URLWithString:urlString];


	NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
	NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
	                                          NSError *jsonError;
	                                          id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
#warning 类型的检查todo
	                                          NSArray *dataArray = [((NSDictionary *)[((NSDictionary *) jsonObj) objectForKey:@"result"]) objectForKey:@"data"];
	                                          NSMutableArray *listItemArray = @[].mutableCopy;
	                                          for (NSDictionary* info in dataArray) {
							  ListItem *listItem = [[ListItem alloc] init];
							  [listItem configWithDictionary:info];
							  [listItemArray addObject:listItem];
						  }
	                                          [weakSelf _archiveListDataWithArray:listItemArray.copy];
	                                          dispatch_async(dispatch_get_main_queue(), ^{
									 if (finishBlock) {
										 finishBlock(error == nil, listItemArray.copy);
									 }
								 });
					  }];

	[dataTask resume];
}

#pragma mark - private method
- (NSArray<ListItem *> *) _readDataFromLocal {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];

    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"Data/list"];
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    
    NSData *readListData = [fileManger contentsAtPath:listDataPath];
    
    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [ListItem class],nil] fromData:readListData error:nil];
    if ([unarchiveObj isKindOfClass:[NSArray
                                     class]] && [unarchiveObj count] > 0) {
        return (NSArray<ListItem *> *) unarchiveObj;
    }
    return  nil;

}

- (void) _archiveListDataWithArray:(NSArray<ListItem *> *) array {
	NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [pathArray firstObject];

	NSFileManager *fileManger = [NSFileManager defaultManager];
	//创建文件夹
	NSString *dataPath = [cachePath stringByAppendingPathComponent:@"Data"];

	NSError *createError;

	[fileManger createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];
	//创建文件
	NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
	//数据写入文件
	NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
	[fileManger createFileAtPath:listDataPath contents:listData attributes:nil];

	//读取二进制流文件
	//NSData *readListData = [fileManger contentsAtPath:listDataPath];

    
    


	//反序列化

//    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [ListItem class],nil] fromData:readListData error:nil];



	[[NSUserDefaults standardUserDefaults] setObject:listData forKey:@"listData"];
	NSData *testListdata = [[NSUserDefaults standardUserDefaults] dataForKey:@"listData"];

	id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [ListItem class],nil] fromData:testListdata error:nil];

	//查询文件
	//BOOL fileExist = [fileManger fileExistsAtPath:listDataPath];

//    //删除
//    if (fileExist) {
//        [fileManger removeItemAtPath:listDataPath error:nil];
//    }

	NSLog(@"");

//	//末尾追加
//	NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
//	[fileHandler seekToEndOfFile];
//	[fileHandler writeData:[@"def" dataUsingEncoding:NSUTF8StringEncoding]];
//
//	//刷新文件 提高实时性
//	[fileHandler synchronizeFile];
//
//	[fileHandler closeFile];

}

@end
