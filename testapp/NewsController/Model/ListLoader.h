//
//  ListLoader.h
//  testapp
//
//  Created by lichun on 2021/7/7.
//

#import <Foundation/Foundation.h>

@class  ListItem;

NS_ASSUME_NONNULL_BEGIN

typedef void (^ListLoaderFinishBlock)(BOOL success, NSArray <ListItem *> *dataArray);


//列表请求
@interface ListLoader : NSObject

- (void) loadListDatawitjFinishBlock:(ListLoaderFinishBlock) finishBlock;

@end

NS_ASSUME_NONNULL_END
