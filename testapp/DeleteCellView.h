//
//  DeleteCellView.h
//  testapp
//
//  Created by lichun on 2021/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeleteCellView : UIView

- (void) showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t) clickBlock;

@end

NS_ASSUME_NONNULL_END
