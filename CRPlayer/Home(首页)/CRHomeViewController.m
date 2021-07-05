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


@interface CRHomeViewController ()
@property (nonatomic, strong) UIButton *goShoppingButton;

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
    
    // Do any additional setup after loading the view.
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
        _goShoppingButton.center = self.view.center;
    }
    return _goShoppingButton;
}

- (void)goShoppingButtonAction {
//    CRShopCartViewController *shopcartVC = [[CRShopCartViewController alloc] init];
//    [self.navigationController pushViewController:shopcartVC animated:YES];
    
    CRMeituanViewController *meituanVC = [[CRMeituanViewController alloc]init];
    [self.navigationController pushViewController:meituanVC animated:YES];
    
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
