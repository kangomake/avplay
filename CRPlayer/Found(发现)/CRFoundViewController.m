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

#import "CRWaveLoadingView.h"
#import "CRTagListView.h"

#import "YYLabel.h"
#import "YYImage.h"
#import "YYText.h"
#import "UIView+YYAdd.h"


#define kNaviHeight ()

@interface CRFoundViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *customView;
@property (nonatomic, strong) CRTagListView *tagListView;

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
            newCenter.y = MIN(kScreenHeight-TabbarHeight -pan.view.frame.size.height/2, newCenter.y);

            newCenter.x = MAX(pan.view.frame.size.width/2, newCenter.x);
            newCenter.x = MIN(kScreenWidth -pan.view.frame.size.width/2, newCenter.x);

            pan.view.center = newCenter;
            
            //pan.view 指的是把pan添加到那个控件上的
            // 因为拖动起来一直是在递增，所以每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图
            [pan setTranslation:CGPointMake(0, 0) inView:self.view];
        
    };
    [self.view addSubview:clock];
    

    UIView *showView = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    showView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:showView];
    
    
    UIImage *showImage = [UIImage imageNamed:@"baidu.png"];
    showView.layer.contents = (__bridge id _Nullable)(showImage.CGImage);
    showView.layer.contentsGravity = kCAGravityResizeAspectFill;
    showView.layer.contentsScale = [UIScreen mainScreen].scale;
    showView.layer.masksToBounds = YES;
    
    /*
     CALayer与 contentMode 对应的属性叫做 contentsGravity ，但是它是一个 NSString类型，而不是像对应的UIKit部分，那里面的值是枚
     举。
     和 cotentMode 一样， contentsGravity 的目的是为了决定内容在图层的边界 中怎么对齐，我们将使用kCAGravityResizeAspect，它的效果等同于 UIViewContentModeScaleAspectFit， 同时它还能在图层中等比例拉伸以适应图层 的边界。
     
     
     UIView有一个叫做 clipsToBounds  的属性可以用来决定是否显示超出边界的内容，CALayer对应的属性叫做 masksToBounds  ，把它设置为YES，就在边界里啦
 
     **/
    
    
//    CRPersonView *personView = [[CRPersonView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:personView];
    
    
    CRWaveLoadingView *waveView = [[CRWaveLoadingView alloc]initWithFrame:CGRectMake(100, 450, 40, 30)];
    waveView.center = self.view.center;
    [self.view addSubview:waveView];
    [waveView startLoading];
    
    
    self.tagListView = [[CRTagListView alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width -20, 20)];
//    [self.view addSubview:self.tagListView];
    
    
    NSArray *testArray = @[@"",@"j",@"g",@"v",@"",@"a",@"hahaha",@"text"];
    [self.tagListView addTags:testArray];
    
    
//    __weak typeof(self) weakSelf = self;

//    self.tagListView.clickTagBlock = ^(NSString * _Nonnull tag) {
//        [weakSelf.tagListView deleteTag:tag];
//    };
    
    
//    [self YYlabelTest];
    [self regulsText];
    // Do any additional setup after loading the view.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSURL *url = [request URL];
    if([[url scheme] isEqualToString:@"firstclick"]){
        
        NSArray *params = [url.query componentsSeparatedByString:@"&"];
        
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
        NSMutableString *strM = [NSMutableString string];
        for (NSString *paramStr in params) {
            NSArray *dictArray = [paramStr componentsSeparatedByString:@"="];
            if(dictArray.count >1){
//                NSString *decodeValue = [dictArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *decodeValue = [dictArray[1] stringByRemovingPercentEncoding];
                decodeValue = [decodeValue stringByRemovingPercentEncoding];
                [tempDict setObject:decodeValue forKey:dictArray[0]];
                [strM appendString:decodeValue];
            }
        }
    }
    
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
//        NSString *encodeString = [url.scheme stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        NSString *encodeString = [url.scheme stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
        return encodeString;
    
    
    return YES;
}





- (void)regulsText{
    [self regulatttt:@"北京红根基建筑有限公司邀请您面试【[职位名称]】" byregex:@"\\[职位名称\\]" withTemplate:@"测试数据"];
    
}

- (NSString *)regulatttt:(NSString *)content byregex:(NSString *)regexStr withTemplate:(NSString *)template{
    
    NSLog(@"替换前%@",content);
    NSLog(@"regexStr-%@,template-%@",regexStr,template);
    NSError *error;
    NSRegularExpression *attachmentExpression = [NSRegularExpression regularExpressionWithPattern:regexStr
    options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [attachmentExpression stringByReplacingMatchesInString:content
                                                                  options:0
                                                range:NSMakeRange(0, [content length])
    withTemplate:template];
    
    NSLog(@"替换后%@",result);

    
    return result;
}

- (void)YYlabelTest{
    
        NSString *messageString = [NSString stringWithFormat:@"face[微笑] 对方%@",@"已倔强"];
        NSAttributedString * text = [self processFromString:messageString];
    
        YYLabel *label02 = [[YYLabel alloc] initWithFrame:CGRectMake(66, 100, kScreenWidth - 120, 20)];
        label02.textAlignment = NSTextAlignmentLeft;
        label02.font = [UIFont systemFontOfSize:12];
        label02.textColor = [UIColor blackColor];
        label02.attributedText = text;
        label02.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:label02];
    
}

#pragma mark ---
- (NSAttributedString *)processFromString:(NSString *)string{
    NSMutableAttributedString * mAttributedString = [[NSMutableAttributedString alloc]init];
    

     NSDictionary * attri = [NSDictionary dictionaryWithObjects:@[[UIFont systemFontOfSize:12.0f],[UIColor blackColor]] forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]];
    [mAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:attri]];
    
    
    //创建匹配正则表达式的类型描述模板
    NSString * pattern = @"face\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    //创建匹配对象
    NSError * error;
    NSRegularExpression * regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
//    //判断
//    if (!regularExpression) {
//        //如果匹配规则对象为nil
//        NSLog(@"正则创建失败！");
//        NSLog(@"error = %@",[error localizedDescription]);
//        return nil;
//    } else {
        NSArray * resultArray = [regularExpression matchesInString:mAttributedString.string options:NSMatchingReportCompletion range:NSMakeRange(0, mAttributedString.string.length)];
        
        NSInteger index = resultArray.count;
        while (index > 0) {
            index --;
            NSTextCheckingResult *result = resultArray[index];
            //根据range获取字符串
            NSString * rangeString = [mAttributedString.string substringWithRange:result.range];
            
//            NSString *imageName =  [FaceDict objectForKey:rangeString];
            NSString *imageName =  @"d_hehe@2x.png";

            if (imageName) {
                //获取图片
//                YYImage * image = [self getImageWithRangeString:imageName];
                YYImage *image = [YYImage imageNamed:imageName];
                image.preloadAllAnimatedImageFrames = YES;
                
                //这是个自定义的方法
//                NSLog(@"image-%@,imageName-%@",image,imageName);
                
                if (image != nil) {
                    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
                    imageView.width = 15;//50
                    imageView.height = 15;//50
//                    NSLog(@"imageView-%@",imageView);
                    NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:[UIFont systemFontOfSize:12.0f] alignment:YYTextVerticalAlignmentCenter];
                    //开始替换
                    [mAttributedString replaceCharactersInRange:result.range withAttributedString:attachText];
                }
            }
        }
//    }
    
    return mAttributedString;
}


- (void)tabbarItemChangeColor:(UIColor *)color{
    
    UINavigationController *nav = self.navigationController;
    UIImage *image_normal = [UIImage imageNamed:@"tabbar_discover"];
    UIImage *image_select = [UIImage imageNamed:@"tabbar_discoverHL"];
    
    UITabBarItem * item = [[UITabBarItem alloc]initWithTitle:@"发现" image:image_normal selectedImage:image_select];
    [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];//调整文字位置
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
    nav.tabBarItem = item;
    
}



#pragma mark --UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
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
    
//    if(indexPath.row % 2 == 0){
//        [self tabbarItemChangeColor:[UIColor blackColor]];
//    }else{
//        [self tabbarItemChangeColor:[UIColor redColor]];
//    }
    
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
