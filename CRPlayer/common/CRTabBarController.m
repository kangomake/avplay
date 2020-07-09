//
//  CRTabBarController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/7/9.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRTabBarController.h"
#import "ViewController.h"

#define kClassKey  @"rootVCClassString"
#define kTitleKey  @"title"
#define kImgKey    @"imageName"
#define kSelImgKey @"selectedImageName"

@interface CRTabBarController ()
@property (nonatomic, assign) NSInteger indexFlag;

@end

@implementation CRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *childItemsArray = [[NSArray alloc]init];

    childItemsArray = @[
        @{ kClassKey: @"HRHomeViewController",
           kTitleKey: @"主页",
           kImgKey: @"tabbar_home",
           kSelImgKey: @"tabbar_homeHL" },

        @{ kClassKey: @"ViewController",
           kTitleKey: @"视频",
           kImgKey: @"tabbar_message",
           kSelImgKey: @"tabbar_messageHL" },

        @{ kClassKey: @"HRMessageFoundController",
           kTitleKey: @"发现",
           kImgKey: @"tabbar_found",
           kSelImgKey: @"tabbar_foundHL" },

        @{ kClassKey: @"HRResumeViewController",
           kTitleKey: @"mine",
           kImgKey: @"tabbar_resume",
           kSelImgKey: @"tabbar_resumeHL" } ];

    self.tabBar.tintColor = [UIColor orangeColor];

    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        //        NSLog(@"class--%@",dict[kClassKey]);
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];       //调整文字位置

        [item setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor orangeColor] } forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];

    // Do any additional setup after loading the view.
}

#pragma mark --- UITabBarControllerDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *array = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [array addObject:btn];
            }
        }
        //添加动画
        //---将下面的代码块直接拷贝到此即可---

        //放大效果，并回到原位
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //速度控制函数，控制动画运行的节奏
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 0.2;       //执行时间
        animation.repeatCount = 1;      //执行次数
        animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
        animation.fromValue = [NSNumber numberWithFloat:0.9];   //初始伸缩倍数
        animation.toValue = [NSNumber numberWithFloat:1.2];     //结束伸缩倍数
//        [[array[index] layer] addAnimation:animation forKey:nil];

        self.indexFlag = index;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
