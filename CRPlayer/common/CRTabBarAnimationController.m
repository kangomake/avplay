//
//  CRTabBarAnimationController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/23.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRTabBarAnimationController.h"
#import "CRAnimationManager.h"
#import "CRNavigationController.h"

#define kClassKey  @"rootVCClassString"
#define kTitleKey  @"title"
#define kImgKey    @"imageName"
#define kSelImgKey @"selectedImageName"


@interface CRTabBarAnimationController ()<UITabBarControllerDelegate>

@end

@implementation CRTabBarAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.delegate = self;
    
    
    NSArray *childItemsArray = [[NSArray alloc]init];

    childItemsArray = @[
        @{ kClassKey: @"CRHomeViewController",
           kTitleKey: @"主页",
           kImgKey: @"tabbar_home",
           kSelImgKey: @"tabbar_homeHL" },

        @{ kClassKey: @"ViewController",
           kTitleKey: @"视频",
           kImgKey: @"tabbar_message",
           kSelImgKey: @"tabbar_messageHL" },

        @{ kClassKey: @"CRFoundViewController",
           kTitleKey: @"发现",
           kImgKey: @"tabbar_discover",
           kSelImgKey: @"tabbar_discoverHL" },

        @{ kClassKey: @"CRMineViewController",
           kTitleKey: @"mine",
           kImgKey: @"tabbar_me",
           kSelImgKey: @"tabbar_meHL" } ];

    self.tabBar.tintColor = [UIColor orangeColor];

    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        //        NSLog(@"class--%@",dict[kClassKey]);
        CRNavigationController *nav = [[CRNavigationController alloc] initWithRootViewController:vc];
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


- (nullable id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    return [[CRAnimationManager alloc] init];
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
