//
//  VideoPlayer.m
//  testapp
//
//  Created by lichun on 2021/7/19.
//

#import "VideoPlayer.h"
#import "AVFoundation/AVFoundation.h"

@interface VideoPlayer ()

@property(nonatomic, strong, readwrite) AVPlayer *avPlayer;
@property(nonatomic, strong, readwrite) AVPlayerItem *videoItem;
@property(nonatomic, strong, readwrite) AVPlayerLayer *playLayer;

@end

@implementation VideoPlayer


// 使用GC提供的dispatch_once 来执行只需运行一次的线程安全代码，单例模式
+ (VideoPlayer *) Player {
	static VideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[VideoPlayer alloc] init];
    });
	return player;
}

- (void) playVideoWithUrl: (NSString *)videoUrl attachView:(UIView *) attachView {
    [self _stopPlay];
    
    // 播放本地视频
    NSURL *videoURL = [NSURL fileURLWithPath:videoUrl];
    
    // NSURL *videoURL = [NSURL URLWithString:videoUrl];
	AVAsset *asset = [AVAsset assetWithURL:videoURL];
	_videoItem = [AVPlayerItem playerItemWithAsset:asset];
	[_videoItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
	[_videoItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
	CMTime duration = _videoItem.duration;
	CGFloat videoDuration = CMTimeGetSeconds(duration);

	// 播放进度获取
	_avPlayer = [AVPlayer playerWithPlayerItem:_videoItem];
	[_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
	         NSLog(@"play: %@", @(CMTimeGetSeconds(time)));
	 }];

	_playLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
	_playLayer.frame = attachView.bounds;
	[attachView.layer addSublayer:_playLayer];
	
    // 中心化管理，监听视频播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void) _stopPlay {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
	[_playLayer removeFromSuperlayer];
    _avPlayer = nil;
    
	_videoItem = nil;
	[_videoItem removeObserver:self forKeyPath:@"status"];
	[_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

// 播放结束后重新播放
- (void) _handlePlayEnd {

	[_avPlayer seekToTime:CMTimeMake(0, 1)];
	[_avPlayer play];
}


#pragma mark - KVO

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
	if ([keyPath isEqualToString:@"status"]) {
		if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay) {
			[_avPlayer play];
		} else {
			NSLog(@"");
		}
	} else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
		NSLog(@"load: %@", [change objectForKey:NSKeyValueChangeNewKey]);
	}
}

@end
