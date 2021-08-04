//
//  CollectionWaterfallLayout.h
//  testapp
//
//  Created by lichun on 2021/7/22.
//

#import <UIKit/UIKit.h>

// 表明指针本身不能变
extern NSString * const kSupplementaryViewKindHeader;

@protocol CollectionWaterfallLayoutProtocol;

@interface CollectionWaterfallLayout : UICollectionViewLayout

// 协议作为属性一般使用 weak 修饰, weak适用于delegate等引用类型，不会导致野指针问题，也不会循环引用，非常安全
@property (nonatomic, weak) id <CollectionWaterfallLayoutProtocol> delegate;
// assign是指针赋值，不对引用计数操作，适用于基本数据类型如NSInteger, int, float, struct等值类型，不适用于引用类型。
@property (nonatomic, assign) NSUInteger columns;
@property (nonatomic, assign) CGFloat columnSpacing;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) UIEdgeInsets insets;

@end

@protocol CollectionWaterfallLayoutProtocol <NSObject>

- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath;

@end
