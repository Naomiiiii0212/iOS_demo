//
//  NormalTableViewCell.h
//  testapp
//
//  Created by lichun on 2021/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class  ListItem;



@protocol NormalTableViewCellDelegate <NSObject>
//点击删除按钮
- (void) tableViewCell: (UITableViewCell *) tableViewCell clickDeleteButton: (UIButton *) deleteButton;

@end

//新闻列表cell
@interface NormalTableViewCell : UITableViewCell

@property(nonatomic, weak, readwrite) id<NormalTableViewCellDelegate> delegate;

- (void) layoutTableViewCellWithItem:(ListItem *) item;

@end

NS_ASSUME_NONNULL_END
