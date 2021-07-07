//
//  NormalTableViewCell.h
//  testapp
//
//  Created by lichun on 2021/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NormalTableViewCellDelegate <NSObject>

- (void) tableViewCell: (UITableViewCell *) tableViewCell clickDeleteButton: (UIButton *) deleteButton;

@end

@interface NormalTableViewCell : UITableViewCell

@property(nonatomic, weak, readwrite) id<NormalTableViewCellDelegate> delegate;

- (void) layoutTableViewCell;

@end

NS_ASSUME_NONNULL_END
