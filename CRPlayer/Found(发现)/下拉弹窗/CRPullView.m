//
//  CRPullView.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/3/2.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRPullView.h"
#import "CRScreen.h"


static const CGFloat kSelfHeight = 200;

@interface CRPullView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *bgBtn;

@end

@implementation CRPullView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        [self setUp];

    }
    return self;
}


- (void)setUp{
    // 背景Btn
    self.bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bgBtn.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height);
    [self.bgBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.bgBtn];
    
    // 分享视图
    self.contentView = ({
        UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, -kSelfHeight, kScreenWidth, kSelfHeight)];
        shareView.backgroundColor = RGB(240, 240, 240);
        
        
        //add
        UIImage *showImage = [UIImage imageNamed:@"baidu.png"];
        shareView.layer.contents = (__bridge id _Nullable)(showImage.CGImage);
        shareView.layer.contentsGravity = kCAGravityResizeAspectFill;
        shareView.layer.contentsScale = [UIScreen mainScreen].scale;
        shareView.layer.masksToBounds = YES;
        
        [self addSubview:shareView];
        shareView;
    });
    
//    // 上ScrollView
//    UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 126)];
//    topScrollView.tag = 1;
//    topScrollView.showsHorizontalScrollIndicator = NO;
//    topScrollView.backgroundColor = RGBColor(240, 240, 240);
//    [self.shareView addSubview:topScrollView];
//
//    // 分割线
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(topScrollView.frame) + 2, kScreenWidth - 20 * 2, 0.5)];
//    lineView.backgroundColor = [UIColor lightGrayColor];
//    [self.shareView addSubview:lineView];
//
//    // 下ScrollView
//    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame) + 2, kScreenWidth, 126)];
//    bottomScrollView.tag = 2;
//    bottomScrollView.showsHorizontalScrollIndicator = NO;
//    bottomScrollView.backgroundColor = RGBColor(240, 240, 240);
//    [self.shareView addSubview:bottomScrollView];
//
//    // 关闭Btn
//    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    closeBtn.frame = CGRectMake(0, CGRectGetMaxY(bottomScrollView.frame), kScreenWidth, 44);
//    closeBtn.backgroundColor = [UIColor whiteColor];
//    closeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
//    [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [self.shareView addSubview:closeBtn];
//
//    // 设置数据
//    [self setDataSourceWithTopScrollView   :topScrollView];
//    [self setDataSourceWithBottomScrollView:bottomScrollView];
}

// 显示
- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    NSTimeInterval i     = 0;
    NSTimeInterval delay = 0;

    for (UIView *subView in self.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIScrollView class]]) {
            
//            UIScrollView *scrollView = (UIScrollView *)subView;
//
//            for (UIView *subView in scrollView.subviews) {
//                if ([subView isKindOfClass:[YYShareButton class]]) {
//                    if (i == 5) {
//                        delay = 0;
//                    }
//                    delay += 0.04;
//                    i += 1;
//
//                    YYShareButton *shareBtn = (YYShareButton *)subView;
//                    [shareBtn shakeBtnWithDely:delay];
//                }
//            }
        }
    }
    
    self.alpha = 0.0f;
    
//    [UIView animateWithDuration:0.2f animations:^{
//        self.alpha = 1.0f;
//        self.contentView.frame = CGRectMake(0, kScreenHeight - kSelfHeight, kScreenWidth, kSelfHeight);
//    }];
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1.0f;
        self.contentView.frame = CGRectMake(0, 0, kScreenWidth, kSelfHeight);
        
        
        
        self.bgBtn.frame = CGRectMake(0, kSelfHeight, kScreenWidth, self.frame.size.height - kSelfHeight);

//        [self addSubview:self.bgBtn];
    } completion:nil];
    
    
}

// 关闭
- (void)dismiss
{
    [UIView animateWithDuration:0.2f animations:^{
        self.contentView.frame = CGRectMake(0, -kSelfHeight, kScreenWidth, kSelfHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc
{
    NSLog(@"%@ -- dealoc", NSStringFromClass([self class]));
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
