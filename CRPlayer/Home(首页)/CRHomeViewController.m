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

#import <CommonCrypto/CommonDigest.h>
#import "UIView+NTES.h"

#import "WKWebViewController.h"

#import <MediaPlayer/MPVolumeView.h>
#import <MediaPlayer/MPMusicPlayerController.h>
#import <StoreKit/StoreKit.h>

#import "CRPerson.h"
#import "CRStudent.h"
#import <objc/runtime.h>
#import "CRCalendarController.h"

@interface CRHomeViewController ()<SKStoreProductViewControllerDelegate>
@property (nonatomic, strong) UIButton *goShoppingButton;
@property (nonatomic, strong) UIButton *alertButton;
@property (strong, nonatomic) MPVolumeView *volumeView;
@property (strong, nonatomic) UISlider *volumeViewSlider;
@property (nonatomic, strong) UIButton *volumeClose;
@property (nonatomic, strong) UIButton *datePickBtn;

@property (nonatomic, strong) UITextField *timeTextField;


@end

@implementation CRHomeViewController

/**
 __func__  是C99标准的一部分
 static const char __func__[] = "function-name";
 __FUNCTION__ 程序预编译时预编译器将用所在的函数名，返回值是字符串;
 跟_ func _ 效果一样，只是为了兼容旧版的GCC
 __FUNCTION__意思主要是指：当前正在编译文件对应 的函数名 返回值是一个字符串；
 */


- (void)viewDidLoad {
    [super viewDidLoad];

    
    
//    id cls = [CRPerson class];
//    NSLog(@"%p",[CRPerson class]);
//    void *obj = &cls;
//    [(__bridge  id)obj test];
//    [cls test];
    
    CRPerson *person = [[CRPerson alloc] init];
    NSLog(@"%p",[person class]);//0x10487f368
    NSLog(@"%@",person);//person->isa  $0 = 0x010000010487f369
    
    
//    [person test];
    
    object_setClass(person, [CRStudent class]);
    [person run];
    
    
    object_isClass(person);
    object_isClass([person class]);
    object_isClass(object_getClass([person class]));
    
    
    class_isMetaClass([person class]);
    class_getSuperclass([person class]);
    
    NSLog(@"haha:%@-%@",object_getClass(person), objc_getClass("CRPerson"));
    
    Ivar nameIvar = class_getInstanceVariable([person class], "_name");
    NSLog(@"%s, %s",ivar_getName(nameIvar),ivar_getTypeEncoding(nameIvar));
    
    
    object_setIvar(person, nameIvar, @"crName");
    NSLog(@"%@",object_getIvar(person, nameIvar));
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList([CRPerson class], &count);
    for (int i = 0;i < count;i ++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s, %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
        
    }
    free(ivars);
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    
    
    NSDictionary *dict = @{ @"secretId": @"1",
                            @"timestamp": @"2",
                            @"nonce": @"3",
                            @"signatureMethod": @"md5", };

//    [self genSignature:dict secretKey:@"6308afb129ea00301bd7c79621d07591"];

    [self.view addSubview:self.goShoppingButton];

    //shiti
//    dispatch_queue_t serialqueue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
//    __unused dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    dispatch_async(serialqueue, ^{
//        dispatch_sync(serialqueue, ^{
//            NSLog(@"1");
//        });
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

//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_group_leave(group);
//    });

    [self.view addSubview:self.alertButton];
    [self.view addSubview:self.volumeClose];
    [self.view addSubview:self.datePickBtn];

    self.timeTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 300, 200, 40)];
    self.timeTextField.returnKeyType = UIReturnKeyDone;
    self.timeTextField.backgroundColor = [UIColor orangeColor];
    self.timeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.timeTextField.textAlignment = NSTextAlignmentLeft;
    self.timeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.timeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.timeTextField.font = [UIFont systemFontOfSize:14];
    self.timeTextField.placeholder = @"请填写";
    [self.view addSubview:self.timeTextField];
    
    
    [self configDatePicker];
    
    [self volumeViewConfig];
//    [self musicPlayer];
    
//    NSLog(@"%@ %@", [self class],[super class]);

    
//    CRPerson *person = [[CRPerson alloc]init];
//    CRStudent *student = [[CRStudent alloc] init];
    
    
    
    
//    [self runtimeTest];
    
    // Do any additional setup after loading the view.
}

void run (id self, SEL _cmd){
    NSLog(@"%@-%@",self, NSStringFromSelector(_cmd));
}

- (void)runtimeTest{
    
    Class newClass = objc_allocateClassPair([NSObject class], "Student", 0);
    class_addIvar(newClass, "_age", 4, 1, @encode(int));
    class_addIvar(newClass, "_height", 4, 1, @encode(float));
    
    class_addMethod(newClass, @selector(run), (IMP)run, "v@:");
    objc_registerClassPair(newClass);
    
    id student = [[newClass alloc] init];
    
    [student setValue:@15 forKey:@"_age"];
    [student setValue:@176.5 forKey:@"_height"];
    
    // 获取成员变量
    NSLog(@"_age = %@ , _height = %@",[student valueForKey:@"_age"], [student valueForKey:@"_height"]);
    
    NSLog(@"%zd",class_getInstanceSize(newClass));
    
    
//    object_getClass(newClass);
//    objc_getClass(newClass);
    
}


- (void)testSKAdNetwork{
    
    if (@available(iOS 11.3, *)) {
        [SKAdNetwork registerAppForAdNetworkAttribution];
        if (@available(iOS 14.0, *)) {
            [SKAdNetwork updateConversionValue:5];
        }
    }
    
   
    if (@available(iOS 14.5, *)) {
        SKAdImpression *imp  = [[SKAdImpression alloc]init];
        [SKAdNetwork startImpression:imp completionHandler:^(NSError * _Nullable error) {
                
        }];
    }
    
    
}

- (void)goToStoreView {
    SKStoreProductViewController *storeVC = [[SKStoreProductViewController alloc] init];
    storeVC.delegate = self;
    [self presentViewController:storeVC animated:YES completion:^{
        [storeVC loadProductWithParameters:@{ SKStoreProductParameterITunesItemIdentifier: @"testappid" } completionBlock:^(BOOL result, NSError *_Nullable error) {
            if (error) {
                NSLog(@"error = %@", error);
            } else {
                NSLog(@"显示完成");
            }
        }];
    }];
}

#pragma mark -- SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    //点击完成或是下载更新完成的回调，dismiss掉VC
    [viewController dismissViewControllerAnimated:YES completion:nil];
}



//插件起作用 injectionIII
- (void)injected {
    [_alertButton setBackgroundColor:[UIColor blueColor]];
    _alertButton.centerX = 50;
}

- (void)volumeCloseClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.volumeViewSlider setValue:0 animated:YES];
        [self.volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.volumeViewSlider setValue:0.5 animated:YES];
        [self.volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark --音量控制
//ios13以下使用
- (void)volumeViewConfig {
    if (!self.volumeView) {
        self.volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(-1000, -100, 100, 100)];

        for (UIView *view in [self.volumeView subviews]) {
            if ([view.class.description isEqualToString:@"MPVolumeSlider"]) {
                self.volumeViewSlider = (UISlider *)view;
                break;
            }
        }
    }
    [self.volumeView setFrame:CGRectMake(30, 300, [UIScreen mainScreen].bounds.size.width - 60, 20)];
    [self.view addSubview:self.volumeView];

//    self.volumeView.showsVolumeSlider = NO;
//    self.volumeViewSlider.value = 0;
}

//- (void)musicPlayer{
//    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
//
//    if (([musicPlayer respondsToSelector:@selector(setVolume:)]) && [[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0) {
//    //消除警告
//    #pragma clang diagnostic push
//    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
//                [musicPlayer setVolume:0];
//    #pragma clang diagnostic pop
//            }
//}

#pragma mark ---semaphore 信号量练习
//当信号量的当前值小于初始化，释放信号量时，会导致崩溃，简而言之就是，signal的调用次数一定要大于等于wait的调用次数，否则导致崩溃。
- (void)semaphore_test_willCrash {
    dispatch_semaphore_t semp = dispatch_semaphore_create(1);
    dispatch_block_t block = ^{
        dispatch_semaphore_signal(semp);
        NSLog(@"signal");
    };

//      NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i++) {
        NSLog(@"wait");
        dispatch_semaphore_wait(semp, DISPATCH_TIME_FOREVER);
        if (i > 2) {  //当I大于2时，只执行 wait ，没执行signal
            break;
        } else { //当I小于等于2时，signal与wait是配对的
            block();
        }
    }
}

- (void)semaphore_test_withDispatch_group {
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%@-%i", [NSThread currentThread], i);
            sleep(1);
            dispatch_semaphore_signal(semaphore);
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

#pragma mark -- tool
- (NSString *)genSignature:(NSDictionary *)dict secretKey:(NSString *)secretKey {
    //将所有的key放进数组
    NSArray *allKeyArray = [dict allKeys];

    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult (id _Nonnull obj1, id _Nonnull obj2) {
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];

    NSLog(@"afterSortKeyArray-%@", afterSortKeyArray);
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
- (NSString *)md5:(NSString *)aText{
    const char *cStr = [aText UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }

    return [hash lowercaseString];
}

- (void)sortedDictionary:(NSDictionary *)dict {
    //将所有的key放进数组
    NSArray *allKeyArray = [dict allKeys];

    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult (id _Nonnull obj1, id _Nonnull obj2) {
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
    NSLog(@"resultString:%@", resultString);
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
    if (_goShoppingButton == nil) {
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

- (UIButton *)alertButton {
    if (!_alertButton) {
        _alertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alertButton setTitle:@"alertButton-GoHtml" forState:UIControlStateNormal];
        [_alertButton addTarget:self action:@selector(alertShow) forControlEvents:UIControlEventTouchUpInside];
        _alertButton.layer.cornerRadius = 5;
        _alertButton.layer.masksToBounds = YES;
        [_alertButton setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
        _alertButton.frame = CGRectMake(0, 0, 200, 40);
        _alertButton.centerX = self.view.centerX;
        _alertButton.top = 150;
    }
    return _alertButton;
}

- (UIButton *)volumeClose {
    if (!_volumeClose) {
        _volumeClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_volumeClose setTitle:@"volumeClose" forState:UIControlStateNormal];
        [_volumeClose setTitle:@"volumeOpen" forState:UIControlStateSelected];
        [_volumeClose addTarget:self action:@selector(volumeCloseClick:) forControlEvents:UIControlEventTouchUpInside];
        _volumeClose.layer.cornerRadius = 5;
        _volumeClose.layer.masksToBounds = YES;
        [_volumeClose setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
        _volumeClose.frame = CGRectMake(0, 0, 200, 40);
        _volumeClose.centerX = self.view.centerX;
        _volumeClose.top = 200;
    }
    return _volumeClose;
}

- (UIButton *)datePickBtn{
    if (!_datePickBtn) {
        _datePickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_datePickBtn setTitle:@"datePickBtn" forState:UIControlStateNormal];
        [_datePickBtn addTarget:self action:@selector(datePickClick:) forControlEvents:UIControlEventTouchUpInside];
        _datePickBtn.layer.cornerRadius = 5;
        _datePickBtn.layer.masksToBounds = YES;
        [_datePickBtn setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
        _datePickBtn.frame = CGRectMake(0, 0, 200, 40);
        _datePickBtn.centerX = self.view.centerX;
        _datePickBtn.top = 250;
    }
    return _datePickBtn;
}

- (void)datePickClick:(UIButton *)sender{
    CRCalendarController *VC = [[CRCalendarController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)configDatePicker{
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    if (@available(iOS 13.4, *)) {
        datePicker.preferredDatePickerStyle = UIDatePickerStyleAutomatic;
    }
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date] animated:YES];
//    [datePicker setMaximumDate:[NSDate date]];
    [datePicker setMinimumDate:[NSDate date]];
//    [datePicker setMinuteInterval:2];
    datePicker.frame = CGRectMake(100, 500, 200, 40);
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    self.timeTextField.inputView = datePicker;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy年 MM月 dd日";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    
    self.timeTextField.text = dateStr;
}

- (void)goShoppingButtonAction {
//    CRShopCartViewController *shopcartVC = [[CRShopCartViewController alloc] init];
//    [self.navigationController pushViewController:shopcartVC animated:YES];

    CRMeituanViewController *meituanVC = [[CRMeituanViewController alloc]init];
    [self.navigationController pushViewController:meituanVC animated:YES];
}

- (void)alertShow {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];

    // 使用富文本来改变alert的title字体大小和颜色
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"这里是标题"];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, 2)];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [alert setValue:title forKey:@"attributedTitle"];

    // 使用富文本来改变alert的message字体大小和颜色
    // NSMakeRange(0, 2) 代表:从0位置开始 两个字符
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"这里是正文信息，myhtml-go"];
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

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        [self pushWKWebView];
    }];

    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

    //
}

- (void)pushWKWebView {
    WKWebViewController *web = [[WKWebViewController alloc]init];
    [self.navigationController pushViewController:web animated:YES];
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
