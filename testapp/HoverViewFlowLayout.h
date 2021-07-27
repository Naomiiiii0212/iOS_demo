//
//  HoverViewFlowLayout.h
//  testapp
//
//  Created by lichun on 2021/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoverViewFlowLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat topHeight;

- (instancetype) initWithTopHeight: (CGFloat) height;

@end

NS_ASSUME_NONNULL_END
