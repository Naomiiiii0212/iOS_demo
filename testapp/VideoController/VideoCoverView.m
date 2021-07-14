//
//  VideoCoverView.m
//  testapp
//
//  Created by lichun on 2021/7/13.
//

#import "VideoCoverView.h"
#import "AVFoundation/AVFoundation.h"
@interface VideoCoverView()

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
    }
    return self;
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
    AVPlayerItem *videoItem = [AVPlayerItem playerItemWithAsset:asset];
    AVPlayer *avPlater = [AVPlayer playerWithPlayerItem:videoItem];
    AVPlayerLayer *playLayer = [AVPlayerLayer playerLayerWithPlayer:avPlater];
    
    playLayer.frame = _coverView.bounds;
    [_coverView.layer addSublayer:playLayer];
    
    [avPlater play];
    
    NSLog(@"");
}

@end
