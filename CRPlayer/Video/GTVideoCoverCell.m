//
//  GTVideoCoverCell.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/6/9.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "GTVideoCoverCell.h"
#import "GTVideoPlayer.h"
#import "GTVideoToolbar.h"
#import "CRScreen.h"

#define GTVideoToolbarHeight 60

@interface GTVideoCoverCell ()
@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, copy, readwrite) NSString *videoUrl;
@property (nonatomic, strong, readwrite) GTVideoToolbar *toolbar;

@end


@implementation GTVideoCoverCell


- (void)fun{
    NSLog(@"cell-fun");
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - GTVideoToolbarHeight)];
            _coverView;
        })];

        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - GTVideoToolbarHeight - 50) / 2, 50, 50)];
            _playButton.image = [UIImage imageNamed:@"videoPlay"];
            _playButton;
        })];

        [self addSubview:({
            _toolbar = [[GTVideoToolbar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, GTVideoToolbarHeight)];
            _toolbar;
        })];

        //点击全部Item都支持播放
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)dealloc {
}

#pragma mark - public method

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _videoUrl = videoUrl;
    [_toolbar layoutWithModel:nil];
}

#pragma mark - private method

- (void)_tapToPlay {
    //在当前Item上播放视频
    [[GTVideoPlayer Player] playVideoWithUrl:_videoUrl attachView:_coverView];
}


@end