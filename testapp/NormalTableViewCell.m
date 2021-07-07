//
//  NormalTableViewCell.m
//  testapp
//
//  Created by lichun on 2021/7/5.
//

#import "NormalTableViewCell.h"

@interface NormalTableViewCell ()

@property(nonatomic, strong, readwrite) UILabel *titleLabel;
@property(nonatomic, strong, readwrite) UILabel *sourceLabel;
@property(nonatomic, strong, readwrite) UILabel *commentLabel;
@property(nonatomic, strong, readwrite) UILabel *timeLabel;

@property(nonatomic, strong, readwrite) UIImageView *rightImageView;

@property(nonatomic, strong, readwrite) UIButton *deleteButton;



@end

@implementation NormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self.contentView addSubview:({
			self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 300, 50)];
			self.titleLabel.backgroundColor = [UIColor whiteColor];
			self.titleLabel.font = [UIFont systemFontOfSize:16];
			self.titleLabel.textColor = [UIColor grayColor];
			self.titleLabel;
		})];

		[self.contentView addSubview:({
			self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 20)];
			self.sourceLabel.font = [UIFont systemFontOfSize:12];
			self.sourceLabel.backgroundColor = [UIColor whiteColor];
			self.sourceLabel.textColor = [UIColor grayColor];
			self.sourceLabel;

		})];

		[self.contentView addSubview:({
			self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 50, 20)];
			self.commentLabel.font = [UIFont systemFontOfSize:12];
			self.commentLabel.backgroundColor = [UIColor whiteColor];
			self.commentLabel.textColor = [UIColor grayColor];
			self.commentLabel;
		})];

		[self.contentView addSubview:({
			self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 50, 20)];
			self.timeLabel.font = [UIFont systemFontOfSize:12];
			self.timeLabel.backgroundColor = [UIColor whiteColor];
			self.timeLabel.textColor = [UIColor grayColor];
			self.timeLabel;
		})];

		[self.contentView addSubview:({
			self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(330, 15, 70, 70)];
			self.rightImageView.backgroundColor = [UIColor whiteColor];
			//当图⽚片尺⼨寸和 UIImageView 尺⼨寸不不符的时候，⾃自定义填充⽅方式
			self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
			self.rightImageView;
		})];

		[self.contentView addSubview:({
			self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(290, 80, 30, 20)];
			[self.deleteButton setTitle:@"x" forState:UIControlStateNormal];
			//点击按钮
			[self.deleteButton setTitle:@"v" forState:UIControlStateHighlighted];
			//点击交互逻辑
			[self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
			//self.deleteButton.backgroundColor = [UIColor grayColor];

			//动画圆角calayer
			self.deleteButton.layer.cornerRadius = 10;
			self.deleteButton.layer.masksToBounds = YES;
			self.deleteButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
			self.deleteButton.layer.borderWidth = 2;

			self.deleteButton;
		})];
	}
	return self;
}

- (void) layoutTableViewCell {
	self.titleLabel.text = @"kuaishouios";

	self.sourceLabel.text = @"kuaishou";
	[self.sourceLabel sizeToFit];

	self.commentLabel.text = @"1888评论";
	[self.commentLabel sizeToFit];
	self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 15, self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);

	self.timeLabel.text = @"3min";
	[self.timeLabel sizeToFit];
	self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + 15, self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);

	self.rightImageView.image = [UIImage imageNamed:@"img.png"];
}


// 删除按钮动画响应
- (void) deleteButtonClick {
	if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeleteButton:)]) {
		[self.delegate tableViewCell:self clickDeleteButton:self.deleteButton];
	}
}
@end
