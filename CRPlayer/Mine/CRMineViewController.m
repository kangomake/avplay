//
//  CRMineViewController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2021/7/20.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import "CRMineViewController.h"
#import "CRScreen.h"
#import "MyTableView.h"
#import "CRTouchTestCell.h"

@interface CRMineViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) MyTableView *tableView;

@end

@implementation CRMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *tapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    tapGesture.delegate = self;
    [self.tableView addGestureRecognizer:tapGesture];
    
    // Do any additional setup after loading the view.
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if([NSStringFromClass([touch.view class]) isEqualToString:@"CRTouchTestCell"]){
        return NO;
    }
    return YES;
}


- (void)hideKeyBoard{
    NSLog(@"%s",__FUNCTION__);
}


#pragma mark --UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CRTouchTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if(!cell){
        cell = [[CRTouchTestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"row--%ld",indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    
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
    
    
//    [self showMenuView];
    
//    if(indexPath.row % 2 == 0){
//        [self tabbarItemChangeColor:[UIColor blackColor]];
//    }else{
//        [self tabbarItemChangeColor:[UIColor redColor]];
//    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__FUNCTION__);
//    NSLog(@"touches-%@,event-%@",touches,event);
    [super touchesBegan:touches withEvent:event];

}

#pragma mark -- lazy
- (MyTableView *)tableView{
    
    if(!_tableView){
        _tableView  = [[MyTableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
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
