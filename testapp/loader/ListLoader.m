//
//  ListLoader.m
//  testapp
//
//  Created by lichun on 2021/7/7.
//

#import "ListLoader.h"

@implementation ListLoader

- (void) loadListData {
    NSString *urlString = @"https://www.baidu.com/";
    NSURL *listUrl = [NSURL URLWithString:urlString];

    //__unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listUrl];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@" ");
    }];
    
    [dataTask resume];
    
    NSLog(@"");
}

@end
