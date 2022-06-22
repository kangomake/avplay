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
#import "myXibCell.h"


#import "MineEditController.h"
#import "CRTextEditController.h"


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
    
   CGFloat statusBarHeight = [CRScreen statusBarHeight];
    NSLog(@"statusBarHeight-(%f)",statusBarHeight);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([myXibCell class]) bundle:nil] forCellReuseIdentifier:@"Myxibcell"];
    [self.tableView registerClass:[CRTouchTestCell class] forCellReuseIdentifier:@"CRTouchTestCell"];
    
    
    // Do any additional setup after loading the view.
}


- (void)regularExpression{
    
    NSError *error = nil;
    
    NSString *regularExpStr = @"";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc]initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *contentStr = @"";
    NSMutableString *resultStrM = [NSMutableString stringWithFormat:@"结果:\n"];
    
    if(!regularExp){

    }else{
        NSArray <NSTextCheckingResult *> *resultArray = [regularExp matchesInString:contentStr options:NSMatchingReportProgress range:NSMakeRange(0, contentStr.length)];

    }
    
    
    [regularExp enumerateMatchesInString:contentStr options:NSMatchingReportProgress range:NSMakeRange(0, contentStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
       
        if(result){
            NSString *subStr = [contentStr substringWithRange:result.range];
            [resultStrM appendString:subStr];
        }
        
    }];
    
}


//解决手势冲突的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    myXibCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Myxibcell"];
    
//    CRTouchTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CRTouchTestCell"];
//    if(!cell){
//        cell = [[CRTouchTestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Myxibcell"];
//    }
    
    CRTouchTestCell *cell = [CRTouchTestCell cellWithTableView:tableView];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"row--%ld",indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.leftLabel.text = [NSString stringWithFormat:@"row--%ld",indexPath.row];
    cell.rightLabel.text = @"2021.10.26(23:59:00)";
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row %2 ==0){
        MineEditController *edit = [[MineEditController alloc]init];
//        [self.navigationController pushViewController:edit animated:YES];
    }else{
        CRTextEditController *text = [[CRTextEditController alloc]init];
//        [self.navigationController pushViewController:text animated:YES];
    }
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__FUNCTION__);
//    NSLog(@"touches-%@,event-%@",touches,event);
    [super touchesBegan:touches withEvent:event];

}

#pragma mark -- lazy
- (MyTableView *)tableView{
    
    if(!_tableView){
        
        
        CGFloat navHeight = [CRScreen navigationFullHeight];
        CGFloat tabbarHeight = [CRScreen tabBarFullHeight];
        _tableView  = [[MyTableView alloc]initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight - tabbarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor orangeColor];
        
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
