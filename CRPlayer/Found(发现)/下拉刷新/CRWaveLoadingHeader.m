//
//  CRWaveLoadingHeader.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/10/23.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRWaveLoadingHeader.h"
#import "CRWaveLoadingView.h"

@interface CRWaveLoadingHeader ()

@property (nonatomic, strong) CRWaveLoadingView *loadingView;

@end


@implementation CRWaveLoadingHeader

- (CRWaveLoadingView *)loadingView{
    if(!_loadingView){
        _loadingView = [[CRWaveLoadingView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
//        _loadingView.center = self.center;
        [self addSubview:_loadingView];
    }
    return _loadingView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
 
    //view.constraints可以得到所有的constraint，然后根据NSLayoutConstraint的属性firstAttribute可以得知它是哪种constraint。
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    }
    
    
}



- (void)setState:(MJRefreshState)state{
    [super setState:state];
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        [self.loadingView startLoading];
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView startLoading];
    } else if (state == MJRefreshStateRefreshing) {
        [self.loadingView startLoading];
    }
}

@end
