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
//@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, strong, readwrite) UIButton *playButton;



@property (nonatomic, copy, readwrite) NSString *videoUrl;
@property (nonatomic, strong, readwrite) GTVideoToolbar *toolbar;

@property (nonatomic, strong) UIWindow *mainWindow;
@property (nonatomic, strong) UIView *fullScreenView;


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
            _coverView.userInteractionEnabled = YES;
            _coverView;
        })];

//        [_coverView addSubview:({
//            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - GTVideoToolbarHeight - 50) / 2, 50, 50)];
//            _playButton.image = [UIImage imageNamed:@"videoPlay"];
//            _playButton.userInteractionEnabled = YES;
//            [_playButton addGestureRecognizer:({
//
//                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
//                tapGesture;
//
//            })];
//            _playButton;
//        })];
        
        [_coverView addSubview:({
            _playButton = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - GTVideoToolbarHeight - 50) / 2, 50, 50)];
//            _playButton.image = [UIImage imageNamed:@"videoPlay"];
//            [_playButton setImage:[UIImage imageNamed:@"videoPlay"] forState:UIControlStateNormal];
            [_playButton setBackgroundImage:[UIImage imageNamed:@"videoPlay"] forState:UIControlStateNormal];

            _playButton.userInteractionEnabled = YES;
            [_playButton addTarget:self action:@selector(_tapToPlay:) forControlEvents:UIControlEventTouchUpInside];
//            [_playButton addGestureRecognizer:({
//
//                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
//                tapGesture;
//
//            })];
            _playButton;
        })];
        

        [self addSubview:({
            _toolbar = [[GTVideoToolbar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, GTVideoToolbarHeight)];
            _toolbar.userInteractionEnabled = YES;
            [_toolbar addGestureRecognizer:({
                
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(FullPlay)];
                tapGesture;
                
            })];
            _toolbar;
        })];

        //点击全部Item都支持播放
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
//        [self addGestureRecognizer:tapGesture];
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

- (void)_tapToPlay:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        //在当前Item上播放视频
        [[GTVideoPlayer Player] playVideoWithUrl:_videoUrl attachView:_coverView];
    }else{
        [[GTVideoPlayer Player] videoStop];
    }
    
    
}

- (void)FullPlay{
    
    
    
}



#pragma mark-- 全屏播放


- (void)changeToFullScreen{
    
    [UIView animateWithDuration:0.5 animations:^{
       
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if(orientation == UIDeviceOrientationLandscapeRight){
            [self interfaceOrientation:UIInterfaceOrientationLandscapeLeft];
        }else{
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation{
    
}

- (void)setOrientationLandscapeConstraint:(UIInterfaceOrientation)orientation{
    
}

- (void)setOrientationPortraitConstraint{
    
}

- (void)toOrientation:(UIInterfaceOrientation)orientation {
    // 获取到当前状态条的方向------iOS13已经废弃，所以不能根据状态栏的方向判断是否旋转，手动记录最后一次的旋转方向
//    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    // 判断如果当前方向和要旋转的方向一致,那么不做任何操作
//    if (self.lastInterfaceOrientation == orientation) { return; }
    
    if (@available(iOS 13.0, *)) {
        //iOS 13已经将setStatusBarOrientation废弃，调用此方法无效
    } else {
        [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    }
//    self.lastInterfaceOrientation = orientation;
    
    // 获取旋转状态条需要的时间:
    
    [UIView animateWithDuration:0.5 animations:^{
        // 更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
        // 给你的播放视频的view视图设置旋转
//        self.playerView.transform = CGAffineTransformIdentity;
//        self.playerView.transform = [self getTransformRotationAngleWithOrientation:self.lastInterfaceOrientation];
        // 开始旋转
    } completion:^(BOOL finished) {
        
    }];
}

- (CGAffineTransform)getTransformRotationAngleWithOrientation:(UIInterfaceOrientation)orientation {

    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}


- (UIWindow *)mainWindow{
    
    if(!_mainWindow){
        
        if(@available(iOS 13.0, *)){
            _mainWindow = [UIApplication sharedApplication].windows.firstObject;
        }else{
            _mainWindow = [UIApplication sharedApplication].keyWindow;
        }
        
        
    }
    return _mainWindow;
}





@end
