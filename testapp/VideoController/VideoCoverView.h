//
//  VideoCoverView.h
//  testapp
//
//  Created by lichun on 2021/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoCoverView : UICollectionViewCell

- (void) layoutWithVideoCoverUrl: (NSString *)videoCoverUrl videoUrl:(NSString*)videoUrl;

@end

NS_ASSUME_NONNULL_END
