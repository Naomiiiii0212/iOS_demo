//
//  VideoPlayer.h
//  testapp
//
//  Created by lichun on 2021/7/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayer : NSObject

+ (VideoPlayer *) Player;

- (void) playVideoWithUrl: (NSString *)videoUrl attachView:(UIView *) attachView;

@end

NS_ASSUME_NONNULL_END
