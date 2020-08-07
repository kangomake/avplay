//
//  CRPlayerProgress.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/7.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRPlayerProgress.h"
#import "CRScreen.h"

@implementation CRPlayerProgress
{
    UIProgressView *_progressView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(2, (self.bounds.size.height -2)/2, self.bounds.size.width, self.bounds.size.height/2)];
    [_progressView setTrackTintColor:RGB(11, 15, 18)];
    [_progressView setProgressTintColor:RGB(70, 71, 70)];
    [self addSubview:_progressView];
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [_slider setThumbImage:[UIImage imageNamed:@"video_slider_normal"] forState:UIControlStateNormal];
    [_slider setThumbImage:[UIImage imageNamed:@"video_slider_highted"] forState:UIControlStateHighlighted];
    
    [_slider setMinimumTrackTintColor:RGB(58, 167, 251)];
    [_slider setMaximumTrackTintColor:[UIColor clearColor]];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _slider.continuous = false;
    [self addSubview:_slider];
    
    
}


- (void)setPlaySecond:(float)playSecond{
    
    if(!_slider.isTracking){
        _slider.value = playSecond;
    }
    
}

- (void)setBufferProgress:(float)bufferProgress{
    _progressView.progress = bufferProgress;
}



-(void)sliderValueChanged:(UISlider*)sender
{
    NSLog(@"跳转到了%fs",sender.value);
    
//    if ([_delegate respondsToSelector:@selector(seekToSecond:)]) {
//        [_delegate seekToSecond:sender.value];
//    }
    
    if(self.seekToSecondBlock){
        self.seekToSecondBlock(sender.value);
    }
    
}

- (void)setMaxTime:(CMTime)duration{
    
    if(duration.value == 0){
        return;
    }
    
    float second = CMTimeGetSeconds(duration);
    if(_slider.maximumValue == second){
        return;
    }
    NSLog(@"总时长：%f",second);
    _slider.maximumValue = second;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
