//
//  CRCalendarController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/8/4.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRCalendarController.h"
#import "CRCalendarView.h"
#import "CRScreen.h"

@interface CRCalendarController ()

@end

@implementation CRCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNav];
    
    [self configSubView];
    
    // Do any additional setup after loading the view.
}




- (void)configNav{
    
    self.navigationItem.title = @"日历选择";
    
    //导航栏颜色设置
//    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
    
    //导航栏字体设置
//    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]};
}

- (void)configSubView{
    CRCalendarView *calendarView = [[CRCalendarView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-100)];
    [self.view addSubview:calendarView];
    
//    calendarView.selectColor=UIColor.redColor;
    calendarView.isCanSelectToday=YES;
    calendarView.maxSelectDateDifference=0;
    [calendarView setCompleteDataRefreshUI];

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
