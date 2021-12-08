//
//  CRHomeViewController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/7/9.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRHomeViewController.h"
#import "CRShopCartViewController.h"
#import "CRMeituanViewController.h"

//
#import <CommonCrypto/CommonDigest.h>
#import "UIView+NTES.h"

#import "WKWebViewController.h"

@interface CRHomeViewController ()
@property (nonatomic, strong) UIButton *goShoppingButton;
@property (nonatomic, strong) UIButton *alertButton;


@end

@implementation CRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    NSDictionary *dict = @{@"secretId":@"1",
                           @"timestamp":@"2",
                           @"nonce":@"3",
                           @"signatureMethod":@"md5",
                        };
    
    [self genSignature:dict secretKey:@"6308afb129ea00301bd7c79621d07591"];
    
    
    
//    [self.view addSubview:self.goShoppingButton];
    
    //shiti
//    dispatch_queue_t serialqueue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(serialqueue, ^{
//
//        dispatch_sync(serialqueue, ^{
//            NSLog(@"1");
//        });
//
//    });
//    NSLog(@"2");
//    dispatch_async(serialqueue, ^{
//        NSLog(@"3");
//    });
//    NSLog(@"4");
//    dispatch_sync(serialqueue, ^{
//        NSLog(@"5");
//    });
//    NSLog(@"6");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_group_leave(group);
    });

    [self.view addSubview:self.alertButton];
    
    //0.6 + 0.45 + 0.8 + 0.3*0.37 + 0.28
    
    // Do any additional setup after loading the view.
}

#pragma mark ---semaphore 信号量练习
//当信号量的当前值小于初始化，释放信号量时，会导致崩溃，简而言之就是，signal的调用次数一定要大于等于wait的调用次数，否则导致崩溃。
- (void)semaphore_test_willCrash{
    
    dispatch_semaphore_t semp = dispatch_semaphore_create(1);
      dispatch_block_t block = ^{
          dispatch_semaphore_signal(semp);
          NSLog(@"signal");
      };

//      NSMutableArray *array = [NSMutableArray array];
      for (NSInteger i = 0; i < 4; i++) {
          NSLog(@"wait");
          dispatch_semaphore_wait(semp, DISPATCH_TIME_FOREVER);
          if (i > 2) {//当I大于2时，只执行 wait ，没执行signal
              break;
          }else{ //当I小于等于2时，signal与wait是配对的
              block();
          }
      }
    
}

- (void)semaphore_test_withDispatch_group{
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++)
    {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%@-%i",[NSThread currentThread],i);
            sleep(1);
            dispatch_semaphore_signal(semaphore);
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}



#pragma mark -- tool

- (NSString *)genSignature:(NSDictionary *)dict secretKey:(NSString *)secretKey{
    
    //将所有的key放进数组
    NSArray *allKeyArray = [dict allKeys];

    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray * afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
    

    NSLog(@"afterSortKeyArray-%@",afterSortKeyArray);
    //通过排列的key值获取value
    NSMutableString *resultString = [[NSMutableString alloc]init];
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [dict objectForKey:sortsing];
        [resultString appendString:sortsing];
        [resultString appendString:valueString];
    }
    
    [resultString appendString:secretKey];
    NSString *md5string = [self md5:resultString];
//    NSLog(@"md5-%@,result-%@",md5string,resultString);
    return md5string;
}



// md5加密
- (NSString *)md5:(NSString *)aText
{
    const char *cStr = [aText UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
}



- (void)sortedDictionary:(NSDictionary *)dict{
    //将所有的key放进数组
    NSArray *allKeyArray = [dict allKeys];

    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray * afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];

//        NSLog(@"afterSortKeyArray:%@",afterSortKeyArray);
        //通过排列的key值获取value
    NSMutableString *resultString = [[NSMutableString alloc]init];
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [dict objectForKey:sortsing];
        [resultString appendString:sortsing];
        [resultString appendString:valueString];
    }
    NSLog(@"resultString:%@",resultString);
    
            
}

/**
- (NSComparisonResult)compare:(NSString *)string;
        compare方法的比较原理为,依次比较当前字符串的第一个字母:
        如果不同,按照输出排序结果
        如果相同,依次比较当前字符串的下一个字母(这里是第二个)
        以此类推
        排序结果
        NSComparisonResult resuest = [obj1 compare:obj2];为从小到大,即升序;
        NSComparisonResult resuest = [obj2 compare:obj1];为从大到小,即降序;
        注意:compare方法是区分大小写的,即按照ASCII排序
        */


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
        _goShoppingButton.centerX = self.view.centerX;
        _goShoppingButton.top = 100;
    }
    return _goShoppingButton;
}

- (UIButton *)alertButton{
    if(!_alertButton){
        _alertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alertButton setTitle:@"alertButton" forState:UIControlStateNormal];
        [_alertButton addTarget:self action:@selector(alertShow) forControlEvents:UIControlEventTouchUpInside];
        _alertButton.layer.cornerRadius = 5;
        _alertButton.layer.masksToBounds = YES;
        [_alertButton setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
        _alertButton.frame = CGRectMake(0, 0, 100, 40);
        _alertButton.centerX = self.view.centerX;
        _alertButton.top = 150;
    }
    return _alertButton;
}


- (void)goShoppingButtonAction {
//    CRShopCartViewController *shopcartVC = [[CRShopCartViewController alloc] init];
//    [self.navigationController pushViewController:shopcartVC animated:YES];
    
    CRMeituanViewController *meituanVC = [[CRMeituanViewController alloc]init];
    [self.navigationController pushViewController:meituanVC animated:YES];
    
}

- (void)alertShow{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];
    
    // 使用富文本来改变alert的title字体大小和颜色
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"这里是标题"];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, 2)];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [alert setValue:title forKey:@"attributedTitle"];
    
    
    // 使用富文本来改变alert的message字体大小和颜色
    // NSMakeRange(0, 2) 代表:从0位置开始 两个字符
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"这里是正文信息"];
    [message addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, 6)];
    [message addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [message addAttribute:NSForegroundColorAttributeName value:[UIColor brownColor] range:NSMakeRange(3, 3)];
    
    [alert setValue:message forKey:@"attributedMessage"];
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    // 设置按钮背景图片
    UIImage *accessoryImage = [[UIImage imageNamed:@"3.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [cancelAction setValue:accessoryImage forKey:@"image"];
    
    // 设置按钮的title颜色
    [cancelAction setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
    
    // 设置按钮的title的对齐方式
    [cancelAction setValue:[NSNumber numberWithInteger:NSTextAlignmentLeft] forKey:@"titleTextAlignment"];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushWKWebView];
    }];
    
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    //
    
    
    
    
    
}


- (void)pushWKWebView{
    
    WKWebViewController *web = [[WKWebViewController alloc]init];
    web.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:web animated:YES completion:nil];
    
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
