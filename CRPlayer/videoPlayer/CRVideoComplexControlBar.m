//
//  CRVideoComplexControlBar.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/7.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRVideoComplexControlBar.h"

@implementation CRVideoComplexControlBar{
    
    UIView *_backView;
    UIButton *_playBtn;
    UILabel *_playTimeLabel;
    
    BOOL _pauseProgress;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _progress = [[CRPlayerProgress alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, ProgressHeight)];
    _progress.seekToSecondBlock = ^(float second) {
        
    };
    [self addSubview:_progress];
    
    
    float margin = 10;
    float btnHeight = ControlBarHeight - ProgressHeight - margin;
    
    float viewY = ProgressHeight;
    
    _playBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin, viewY, btnHeight, btnHeight)];
    _playBtn.showsTouchWhenHighlighted = true;
//    [_playBtn addTarget:self action:@selector(playBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [_playBtn addTarget:self action:@selector(playBtnMethod:) forControlEvents:UIControlEventTouchDown];
    [_playBtn setImage:[UIImage imageNamed:@"btn_pause_nomal"] forState:UIControlStateNormal];
    [_playBtn setImage:[UIImage imageNamed:@"btn_play_nomal"] forState:UIControlStateSelected];
    [self addSubview:_playBtn];
    
    
    
    
}


- (void)playBtnMethod:(UIButton *)sender{
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
