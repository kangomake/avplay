//
//  CRFoundViewController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/6.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRFoundViewController.h"
#import "CRScreen.h"
#import "CRMenuView.h"
#import "CRClockView.h"
#import "CRPersonView.h"



#define kNaviHeight ()

@interface CRFoundViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) UIImageView *customView;

@end

@implementation CRFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.customView];

    
    CGFloat navHeight = 88 ;
    CGFloat TabbarHeight = 83 ;
    
    CRClockView *clock = [[CRClockView alloc]initWithFrame:CGRectMake(0, navHeight, 120, 120)];
    clock.panViewBlock = ^(UIPanGestureRecognizer * _Nonnull pan) {
        
        CGPoint point = [pan translationInView:self.view];

            //该方法返回在横坐标上、纵坐标上拖动了多少像素
        //    NSLog(@"%f,%f",point.x,point.y);
            
            //限制屏幕范围
            CGPoint newCenter = CGPointMake(pan.view.center.x +point.x, pan.view.center.y + point.y);
            newCenter.y = MAX(pan.view.frame.size.height/2+navHeight, newCenter.y);
//            newCenter.y = MIN(kScreenHeight- kTabbarHeight - kNaviHeight -pan.view.frame.size.height/2, newCenter.y);
            newCenter.y = MIN(kScreenHeight-TabbarHeight -pan.view.frame.size.height/2, newCenter.y);

            newCenter.x = MAX(pan.view.frame.size.width/2, newCenter.x);
            newCenter.x = MIN(kScreenWidth -pan.view.frame.size.width/2, newCenter.x);

            pan.view.center = newCenter;
            
            //pan.view 指的是把pan添加到那个控件上的
            // 因为拖动起来一直是在递增，所以每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图
            [pan setTranslation:CGPointMake(0, 0) inView:self.view];
        
    };
    [self.view addSubview:clock];
    
    
    CRPersonView *personView = [[CRPersonView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:personView];
    
    // Do any additional setup after loading the view.
}


#pragma mark --UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"row--%ld",indexPath.row];
    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self PopAnimationWithlayoutView];
    
//    [self showMenuView];
    
}

//显示下拉框
- (void)showMenuView{
    
    [CRMenuView initWithItems:@[@"text1",@"text2",@"text3"] picArray:@[@"",@"",@""] width:120 Location:CGPointMake(200, 400) action:^(NSInteger index) {
        NSLog(@"index-%ld",index);
    }];
    
}


- (void)PopAnimationWithlayoutView{
    
    
//    CGPoint startPosition = self.customView.layer.position;
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.customView.layer.position = CGPointMake(0, 64);
        self.customView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 200);
    } completion:nil];
    
    
//    [UIView animateWithDuration:0.5 animations:^{
////        self.customView.layer.position = CGPointMake(0, 64);
//        self.customView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 200);
//    }];
    
}

#pragma mark -- lazy
- (UITableView *)tableView{
    
    if(!_tableView){
        _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (UIImageView *)customView{
    
    if(!_customView){
        _customView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -200, SCREEN_WIDTH, 200)];
        _customView.backgroundColor = [UIColor whiteColor];
        _customView.image = [UIImage imageNamed:@"baidu.png"];
        _customView.layer.borderWidth = 1;
        _customView.layer.borderColor = [UIColor lightTextColor].CGColor;
        _customView.userInteractionEnabled = YES;
        [_customView addGestureRecognizer:({
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView:)];
            tap;
            
        })];
    }
    return _customView;
}

- (void)dismissView:(UITapGestureRecognizer *)tap{
    
    [UIView animateWithDuration:0.5 animations:^{
//        self.customView.layer.position = CGPointMake(0, -100);
        self.customView.frame = CGRectMake(0, -200, SCREEN_WIDTH, 200);
    }];
    
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
