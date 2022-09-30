//
//  MineEditController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2021/10/28.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import "MineEditController.h"
#import "MyTableView.h"
#import "MyEditFoldCell.h"
#import "CRScreen.h"
#import "cellFoldModel.h"
@interface MineEditController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) MyTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MineEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"edit";
    
    
    
    for (int i=0;i<5;i++) {
        cellFoldModel *cellModel = [[cellFoldModel alloc]initWithHeight:80];
        [self.dataArray addObject:cellModel];
    }
    [self.view addSubview:self.tableView];

    
    // Do any additional setup after loading the view.
}
#pragma mark --UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    cellFoldModel *cellModel = self.dataArray[indexPath.row];
    return cellModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyEditFoldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyEditFoldCell"];
    if(!cell){
        cell = [[MyEditFoldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyEditFoldCell"];
    }
    
    cell.titleLabel.text = [NSString stringWithFormat:@"描述描述%ld",indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [self.tableView setContentOffset:CGPointMake(0, 160) animated:YES];
//    return;

    [self reloadCellIndexPath:indexPath];
//    [self clickIndex:indexPath];

}

- (void)reloadCellIndexPath:(NSIndexPath *)indexPath{
    cellFoldModel *cellModel = self.dataArray[indexPath.row];
    if(cellModel.cellHeight == 80){
        cellModel.cellHeight = 300;
    }else{
        cellModel.cellHeight = 80;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}




- (void)clickIndex:(NSIndexPath *)indexPath{
//    NSLog(@"row-%ld",indexPath.row);
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    CGFloat viewShow = [self.tableView rectForRowAtIndexPath:indexPath].origin.y;

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    CGFloat cellY = [self getCurrentEditViewBottom:cell]-88;
    NSLog(@"y-%f",cellY);
    [self.tableView setContentOffset:CGPointMake(0, cellY) animated:YES];
}

- (CGFloat)getCurrentEditViewBottom:(UIView *)view{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    return [view convertRect:view.bounds toView:window].origin.y + view.frame.size.height;
    return [view convertRect:view.bounds toView:window].origin.y ;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"Offset.y-%f",scrollView.contentOffset.y);

}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    NSLog(@"%s",__FUNCTION__);
////    NSLog(@"touches-%@,event-%@",touches,event);
//    [super touchesBegan:touches withEvent:event];
//
//}

#pragma mark -- lazy
- (MyTableView *)tableView{
    
    if(!_tableView){
        _tableView  = [[MyTableView alloc]initWithFrame:CGRectMake(0, 88, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//        _tableView.contentInset = UIEdgeInsetsZero;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
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
