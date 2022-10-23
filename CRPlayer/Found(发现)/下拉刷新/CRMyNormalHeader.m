//
//  CRMyNormalHeader.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/10/23.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRMyNormalHeader.h"

@interface CRMyNormalHeader ()

@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle MJRefreshDeprecated("first deprecated in 3.2.2 - Use `loadingView` property");
//@property (nonatomic, strong) UILabel *endLabel;

@end


@implementation CRMyNormalHeader


- (UIActivityIndicatorView *)loadingView{
    if (!_loadingView) {
        
        if (@available(iOS 13.0, *)) {
            _activityIndicatorViewStyle = UIActivityIndicatorViewStyleMedium;
        }else{
            _activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        }
        
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:_activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = NO;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}


//- (UILabel *)endLabel{
//    if(!_endLabel){
//        _endLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, 20)];
//        _endLabel.text = @"推荐职位已刷新";
//        _endLabel.backgroundColor = UIColor.clearColor;
//        _endLabel.textColor = UIColor.whiteColor;
//        _endLabel.font = [UIFont systemFontOfSize:14];
//        _endLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_endLabel];
//        _endLabel.hidden = YES;
//    }
//    return _endLabel;
//}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    [self.loadingView removeFromSuperview];
    self.loadingView = nil;
    [self setNeedsLayout];
}


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if (@available(iOS 13.0, *)) {
        _activityIndicatorViewStyle = UIActivityIndicatorViewStyleMedium;
//        return;
    }else{
        _activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
//#endif
    
      
    // 小菊花
    //view.constraints可以得到所有的constraint，然后根据NSLayoutConstraint的属性firstAttribute可以得知它是哪种constraint。
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    }
    
    
}




- (void)setState:(MJRefreshState)state{
    [super setState:state];
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        self.loadingView.alpha = 1.0;
        [self.loadingView stopAnimating];
    } else if (state == MJRefreshStatePulling) {
        self.loadingView.alpha = 1.0;
        [self.loadingView stopAnimating];
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
    }
}

@end
