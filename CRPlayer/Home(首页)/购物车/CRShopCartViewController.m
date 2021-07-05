//
//  CRShopCartViewController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/7/9.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRShopCartViewController.h"
#import "CRShopcartTableViewProxy.h"
#import "CRShopcartBottomView.h"
#import "CRShopcartFormat.h"

#import <AudioToolbox/AudioToolbox.h>


#import "CRNotifier.h"
#import "CRNotificationManager.h"


@interface CRShopCartViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CRShopcartTableViewProxy *tableViewProxy;
@property (nonatomic, strong) CRShopcartBottomView *bottomView;
@property (nonatomic, strong) CRShopcartFormat *shopcartFormat;

@end

@implementation CRShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemFillColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        // Fallback on earlier versions
    }
    
//    [self audioTool];
    
    
    [[CRNotificationManager notificationManager] addNotification];
    
        // Do any additional setup after loading the view.
}

//实现回调函数 (c函数)
void soundCompleteCallback(SystemSoundID sound, void *clientData){
    
    NSLog(@"sound-%d",sound);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(sound);
    
}


- (void)stopAlertSoundWithSoundID:(SystemSoundID)sound{
    
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(sound);
    AudioServicesRemoveSystemSoundCompletion(sound);
    
}

- (void)audioTool{
    
    
    CRNotifier *notifier = [[CRNotifier alloc]init];
    [notifier start:@"这是一个测试通知，请查收"];
    
//    AudioServicesAddSystemSoundCompletion(1007, NULL, NULL,soundCompleteCallback, NULL);
}


#pragma mark --- lazy load
- (UITableView *)tableView{
    
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self.tableViewProxy;
        _tableView.dataSource = self.tableViewProxy;
    }
    return _tableView;
}

- (CRShopcartTableViewProxy *)tableViewProxy{
    
    if(!_tableViewProxy){
        _tableViewProxy = [[CRShopcartTableViewProxy alloc]init];
    }
    return _tableViewProxy;
}

- (CRShopcartBottomView *)bottomView{
    
    if(!_bottomView){
        _bottomView = [[CRShopcartBottomView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (CRShopcartFormat *)shopcartFormat{
    
    if(!_shopcartFormat){
        _shopcartFormat = [[CRShopcartFormat alloc]init];
    }
    return _shopcartFormat;
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
