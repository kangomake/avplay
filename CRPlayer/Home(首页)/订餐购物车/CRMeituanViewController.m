//
//  CRMeituanViewController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/21.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRMeituanViewController.h"
#import "CRPushVCManager.h"
#import "CRNotificationManager.h"

@interface CRMeituanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *redView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *ordersArray;
@property (nonatomic, assign) NSInteger totalsOrders;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *codeText;


@end

@implementation CRMeituanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"You get";
    if(@available(iOS 13.0,*)){
        self.view.backgroundColor = [UIColor systemFillColor];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50)];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.tableView ];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"maincell"];
        
    
    NSLog(@"%@",[self numberFormatterWithString:@"00123456.654321"]);
    
//    [self layerTransform];
    
    
    NSDictionary *userInfo = @{
    @"class": @"CRShopCartViewController",
    @"property": @{
            @"ID": @"123",
            @"type": @"12"
            }
    };
    
    
   
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [CRPushVCManager push:userInfo controller:self];
    });
    
        
    
    
    [self.view addSubview:self.imageView];
    UILongPressGestureRecognizer *QrCodeTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(qrCodeLongPress:)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:QrCodeTap];
    
    [self.view addSubview:self.codeText];
    
    
    [[CRNotificationManager notificationManager] addNotification];
    
    // Do any additional setup after loading the view.
}

- (void)qrCodeLongPress:(UILongPressGestureRecognizer *)pressSender {
    if (pressSender.state != UIGestureRecognizerStateBegan) {
        return;//长按手势只会响应一次
    }
    
    UIImageView *imgV = (UIImageView *)pressSender.view;
    
    //创建上下文
    CIContext *context = [[CIContext alloc] init];
    //创建一个探测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    //直接开始识别图片,获取图片特征
    CIImage *imageCI = [[CIImage alloc] initWithImage:imgV.image];
    NSArray *features = [detector featuresInImage:imageCI];
    CIQRCodeFeature *codef = (CIQRCodeFeature *)features.firstObject;
        
    //弹出选项列表
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIImageWriteToSavedPhotosAlbum(imgV.image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
    }];
    UIAlertAction *identifyAction = [UIAlertAction actionWithTitle:@"识别二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@", codef.messageString);
        self.codeText.text = codef.messageString;
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:codef.messageString]];
        
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.codeText.text = @"";
    }];
    [alert addAction:saveAction];
    [alert addAction:identifyAction];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

- (UILabel *)codeText{
    
    if(!_codeText){
        _codeText = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.imageView.frame)+20, [UIScreen mainScreen].bounds.size.width - 20, 50)];
        _codeText.backgroundColor = [UIColor whiteColor];
        _codeText.textColor = [UIColor blackColor];
        _codeText.font = [UIFont systemFontOfSize:13];
        _codeText.numberOfLines = 0;
        _codeText.textAlignment = NSTextAlignmentCenter;
    }
    return _codeText;
}

- (UIImageView *)imageView{
    
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width -150)/2, 200, 150, 150)];
        _imageView.backgroundColor = [UIColor redColor];
        _imageView.image = [UIImage imageNamed:@"cr_qrcode.png"];
    }
    return _imageView;
}


- (void)layerTransform{
    
    CALayer *layer = [[CALayer alloc]init];
    layer.bounds = CGRectMake(100, 100, 100, 100);
    layer.position = CGPointMake(150, 150);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.opacity = 0.7;
    [self.view.layer addSublayer:layer];
    
//    layer.transform = CATransform3DMakeRotation(M_PI_4, 10, 20, 30);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 800;
    transform = CATransform3DRotate(transform, -M_PI_4, 0, 1, 0);
//    layer.transform = transform;
    
    
    
}

- (void)layer_test{
    
    
    
}





#pragma mark -- TableViewDelegate and DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    __weak typeof(self)weakSelf = self;
    
    
    return cell;
    
}



#pragma mark -- Tool

//数字格式化
- (NSString *)numberFormatterWithString:(NSString *)NumberString{
    
    if(!NumberString){
        return @"";
    }
    
    if(NumberString.length == 0){
        return @"";
    }
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    NSNumber *number = [NSNumber numberWithDouble:NumberString.doubleValue];
    return [formatter stringFromNumber:number];
    
    
    
}


#pragma mark -- lazy

- (UIImageView *)redView{
    
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.backgroundColor = [UIColor redColor];
        _redView.image = [UIImage imageNamed:@"adddetail"];
        _redView.layer.cornerRadius = 10;
    }
    return _redView;
    
}

- (NSMutableArray *)ordersArray{
    
    if(!_ordersArray){
        _ordersArray = [[NSMutableArray alloc]init];
    }
    return _ordersArray;
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
