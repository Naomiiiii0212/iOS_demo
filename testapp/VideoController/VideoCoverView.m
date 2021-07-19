//
//  VideoCoverView.m
//  testapp
//
//  Created by lichun on 2021/7/13.
//

#import "VideoCoverView.h"
#import "AVFoundation/AVFoundation.h"
@interface VideoCoverView()

@property(nonatomic, strong, readwrite) AVPlayer *avPlayer;
@property(nonatomic, strong, readwrite) AVPlayerItem *videoItem;
@property(nonatomic, strong, readwrite) AVPlayerLayer *playLayer;
@property(nonatomic, strong, readwrite) UIImageView *coverView;
@property(nonatomic, strong, readwrite) UIImageView *playButton;
@property(nonatomic, copy, readwrite) NSString *videoUrl;

@end

@implementation VideoCoverView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            _coverView;
        })];
        
        // 按钮加入coverView，点击播放后按扭消失
        [_coverView addSubview:({
            // 按钮居中
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - 50) / 2, 50, 50)];
            _playButton;
        })];
        
        // 加入手势，播放按钮响应
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
        
        // 中心化管理，监听视频播放结束
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

// 将自己从单例中移除，单例是整个生命周期
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_videoItem removeObserver:self forKeyPath:@"status"];
    [_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

#pragma mark - public method

- (void) layoutWithVideoCoverUrl: (NSString *)videoCoverUrl videoUrl:(NSString*)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _playButton.image = [UIImage imageNamed:@"icon.bundle/videoPlay.png"];
    _videoUrl = videoUrl;
}

#pragma mark - private method
- (void) _tapToPlay {
    NSURL *videoUrl = [NSURL URLWithString:_videoUrl];
    AVAsset *asset = [AVAsset assetWithURL:videoUrl];
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
    _playLayer.frame = _coverView.bounds;
    [_coverView.layer addSublayer:_playLayer];
    [_avPlayer play];
    
    NSLog(@"");
}

// 播放结束后重新播放
- (void) _handlePlayEnd {
//    [_playLayer removeFromSuperlayer];
//    _videoItem = nil;
//    _avPlayer = nil;
//    NSLog(@"");
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
