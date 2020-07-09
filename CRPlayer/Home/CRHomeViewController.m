//
//  CRHomeViewController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/7/9.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRHomeViewController.h"
#import "CRShopCartViewController.h"

@interface CRHomeViewController ()
@property (nonatomic, strong) UIButton *goShoppingButton;

@end

@implementation CRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.goShoppingButton];
    
    // Do any additional setup after loading the view.
}

- (UIButton *)goShoppingButton {
    if(_goShoppingButton == nil)
    {
        _goShoppingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goShoppingButton setTitle:@"进入购物车" forState:UIControlStateNormal];
        [_goShoppingButton addTarget:self action:@selector(goShoppingButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _goShoppingButton.layer.cornerRadius = 5;
        _goShoppingButton.layer.masksToBounds = YES;
        [_goShoppingButton setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
        _goShoppingButton.frame = CGRectMake(0, 0, 100, 40);
        _goShoppingButton.center = self.view.center;
    }
    return _goShoppingButton;
}

- (void)goShoppingButtonAction {
    CRShopCartViewController *shopcartVC = [[CRShopCartViewController alloc] init];
    [self.navigationController pushViewController:shopcartVC animated:YES];
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
