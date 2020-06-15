//
//  CRSplashView.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/6/15.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRSplashView.h"

#define kScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight  ([UIScreen mainScreen].bounds.size.height)

@interface CRSplashView()

@property(nonatomic, strong, readwrite)UIButton *button;

@end

@implementation CRSplashView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"icon.bundle/splash.png"];
        self.backgroundColor = [UIColor orangeColor];
        [self addSubview:({
            _button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-80, 100, 60, 40)];
            _button.backgroundColor = [UIColor lightGrayColor];
            [_button setTitle:@"跳过" forState:UIControlStateNormal];
            [_button addTarget:self action:@selector(_removeSplashView) forControlEvents:UIControlEventTouchUpInside];
            _button;
        })];
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark -

- (void)_removeSplashView{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
