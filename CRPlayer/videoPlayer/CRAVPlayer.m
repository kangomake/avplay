//
//  CRAVPlayer.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/7.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRAVPlayer.h"
#import <AVFoundation/AVFoundation.h>

@implementation CRAVPlayer{
    
    NSURL * _contentURL;//地址
    AVPlayer *_player;//播放器
    AVPlayerLayer *_playerLayer;//播放器layer
    
}

- (instancetype)initWithFrame:(CGRect)frame Url:(NSString *)url{
    
    if(self = [super initWithFrame:frame]){
        
        _contentURL = [NSURL URLWithString:url];
//        _contentURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"shanghaiwaitan" ofType:@"mp4"]];
        [self initPlayer];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)URL{
    
    if(self = [super initWithFrame:frame]){
        
        _contentURL = URL;
        [self initPlayer];
        
    }
    return self;
    
}


- (void)initPlayer{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:_contentURL];
    
    _player = [AVPlayer playerWithPlayerItem:item];
    _player.volume = 0.5;
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = self.layer.bounds;
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.layer addSublayer:_playerLayer];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidError:) name:AVPlayerItemPlaybackStalledNotification object:_player.currentItem];

}



#pragma mark -- 视频播放通知方法
- (void)moviePlayDidEnd:(NSNotification *)notification{
    
}

- (void)moviePlayDidError:(NSNotification *)notification{
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
