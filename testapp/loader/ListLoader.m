//
//  ListLoader.m
//  testapp
//
//  Created by lichun on 2021/7/7.
//

#import "ListLoader.h"
#import "AFNetworking.h"

@implementation ListLoader

- (void) loadListData {
    NSString *urlString = @"https://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeef798bad3d54e";
    NSURL *listUrl = [NSURL URLWithString:urlString];

//	[[AFHTTPSessionManager manager] GET:@"https://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeef798bad3d54e" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//	 } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//	         NSLog(@"");
//	 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//	         NSLog(@"");
//	 }];





    //__unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listUrl];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        NSLog(@" ");
    }];

    [dataTask resume];

    NSLog(@"");
}

@end
