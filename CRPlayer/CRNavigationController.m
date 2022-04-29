//
//  CRNavigationController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/4/29.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRNavigationController.h"

@interface CRNavigationController ()<UINavigationControllerDelegate>

@end

@implementation CRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count >0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController: viewController animated:animated];
    
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
