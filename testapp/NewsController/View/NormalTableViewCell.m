//
//  NormalTableViewCell.m
//  testapp
//
//  Created by lichun on 2021/7/5.
//

#import "NormalTableViewCell.h"
#import "ListItem.h"
#import "SDWebImage.h"

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
			self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 270, 50)];
			//self.titleLabel.backgroundColor = [UIColor whiteColor];
			self.titleLabel.font = [UIFont systemFontOfSize:16];
			self.titleLabel.textColor = [UIColor blackColor];
			self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
			self.titleLabel;
		})];

		[self.contentView addSubview:({
			self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 50, 20)];
			self.sourceLabel.font = [UIFont systemFontOfSize:12];
			//self.sourceLabel.backgroundColor = [UIColor whiteColor];
			self.sourceLabel.textColor = [UIColor blackColor];
			self.sourceLabel;

		})];

		[self.contentView addSubview:({
			self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 50, 20)];
			self.commentLabel.font = [UIFont systemFontOfSize:12];
			//self.commentLabel.backgroundColor = [UIColor whiteColor];
			self.commentLabel.textColor = [UIColor blackColor];
			self.commentLabel;
		})];

		[self.contentView addSubview:({
			self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 70, 50, 20)];
			self.timeLabel.font = [UIFont systemFontOfSize:12];
			//self.timeLabel.backgroundColor = [UIColor whiteColor];
			self.timeLabel.textColor = [UIColor blackColor];
			self.timeLabel;
		})];

		[self.contentView addSubview:({
			self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 15, 100, 70)];
			self.rightImageView.backgroundColor = [UIColor whiteColor];
			//???????????????????????? UIImageView ?????????????????????????????????????????????????????????
			self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
			self.rightImageView;
		})];

//		[self.contentView addSubview:({
//			self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(290, 80, 30, 20)];
//			[self.deleteButton setTitle:@"x" forState:UIControlStateNormal];
//			//????????????
//			[self.deleteButton setTitle:@"v" forState:UIControlStateHighlighted];
//			//??????????????????
//			[self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
//			//self.deleteButton.backgroundColor = [UIColor grayColor];
//
//			//????????????calayer
//			self.deleteButton.layer.cornerRadius = 10;
//			self.deleteButton.layer.masksToBounds = YES;
//			self.deleteButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//			self.deleteButton.layer.borderWidth = 2;
//
//			self.deleteButton;
//		})];
	}
	return self;
}

- (void) layoutTableViewCellWithItem:(ListItem *) item {

	//????????????
	BOOL hasRead = [[NSUserDefaults standardUserDefaults] boolForKey:item.uniqueKey];

	if (hasRead) {
		self.titleLabel.textColor = [UIColor lightGrayColor];
	} else {
		self.titleLabel.textColor = [UIColor blackColor];
	}

	self.titleLabel.text = item.title;

	self.sourceLabel.text = item.authorName;
	[self.sourceLabel sizeToFit];

	self.commentLabel.text = item.category;
	[self.commentLabel sizeToFit];
	self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 15, self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);

	self.timeLabel.text = item.date;
	[self.timeLabel sizeToFit];
	self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + 15, self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);


// NSThread?????????????????????
//    NSThread *downloadImageThread = [[NSThread alloc] initWithBlock:^{
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
//        self.rightImageView.image = image;
//    }];
//    downloadImageThread.name = @"downloadImageThread";
//    [downloadImageThread start];


//	// GCD??????
//	// ????????????
//	dispatch_queue_global_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//	// ?????????
//	dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
//
//	//??????????????????????????????????????????????????????ui?????????????????????
//	dispatch_async(downloadQueue, ^{
//		UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
//		dispatch_async(mainQueue, ^{
//			self.rightImageView.image = image;
//        });
//    });


	// SDWebImage????????????????????????????????????????????????, SDWebImage????????????????????????????????????????????????
	[self.rightImageView sd_setImageWithURL:[NSURL URLWithString:item.picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
	         NSLog(@"");
	 }];

}

// ????????????????????????
- (void) deleteButtonClick {
	if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeleteButton:)]) {
		[self.delegate tableViewCell:self clickDeleteButton:self.deleteButton];
	}
}
@end
