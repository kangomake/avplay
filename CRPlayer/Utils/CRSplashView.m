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
//        self.image = [UIImage imageNamed:@"icon.bundle/splash.png"];
//        self.image = [UIImage imageNamed:@"1242x2208.png"];
//        self.image = [self getLaunchImage];
//        self.backgroundColor = [UIColor orangeColor];
        
        [self getLaunchViewStoryboard];
        [self addSubview:({
            _button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-80, 80, 60, 35)];
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
//获取启动页
- (UIImage *)getLaunchImage {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOr = @"Portrait";//垂直
    NSString *launchImage = nil;
    NSArray *launchImages = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];

    for (NSDictionary *dict in launchImages) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);

        if (CGSizeEqualToSize(viewSize, imageSize) && [viewOr isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
//    NSLog(@"launchImage-%@",launchImage);
    return [UIImage imageNamed:launchImage];
}
- (void)_removeSplashView{
    [self removeFromSuperview];
}

//PS:记得给LaunchScreen.storyboard里的ViewController设置好Storyboard ID
- (void)getLaunchViewStoryboard{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIView *launchView = viewController.view;
    
    [self addSubview:launchView];
//    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
//    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
//    [mainWindow addSubview:launchView];
//    [UIView animateWithDuration:0.6f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        launchView.alpha = 0.0f;
//        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 1.0f);
//    } completion:^(BOOL finished) {
//        [launchView removeFromSuperview];
//    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
