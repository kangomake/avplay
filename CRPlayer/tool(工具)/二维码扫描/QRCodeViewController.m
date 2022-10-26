//
//  QRCodeViewController.m
//  hr_renzheng
//
//  Created by appleDeveloper on 2021/4/20.
//

#import "QRCodeViewController.h"
#import "QRCode.h"
#import "QRScanBottomView.h"
#import "WebViewController.h"


#define Device_Width  [[UIScreen mainScreen] bounds].size.width//获取屏幕宽高
#define Device_Height [[UIScreen mainScreen] bounds].size.height
#define NAVH (MAX(Device_Width, Device_Height)  == 812 ? 88 : 64)
/** 扫描内容的 W 值 */
#define scanBorderW 0.7 * [UIScreen mainScreen].bounds.size.width
/** 扫描内容的 x 值 */
#define scanBorderX 0.5 * (1 - 0.7) * [UIScreen mainScreen].bounds.size.width
/** 扫描内容的 Y 值 */
#define scanBorderY 0.32 * (self.view.frame.size.height - scanBorderW)


@interface QRCodeViewController ()

@property (nonatomic, strong) QRCodeScanManager *scanManager;
@property (nonatomic, strong) QRCodeScanView *scanView;

@property (nonatomic, strong) UILabel *promptLabel;//提示文字
@property (nonatomic, strong) UIView *topContainer;//包一层是防止push动画的的问题（不能为纯透明）

@property (nonatomic, strong) QRScanBottomView *bottomBtnView;/** 底部按钮view*/

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scanView addTimer];
    [_scanManager startRunning];
    [_scanManager resetSampleBufferDelegate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self stopScan];
}


- (void)setUp {
    [self.view addSubview:self.topContainer];
    [self.topContainer addSubview:self.scanView];
    [self.topContainer addSubview:self.promptLabel];
    [self setupScanManager];
//    [self.view addSubview:self.bottomBtnView];
}

- (void)setupScanManager {
    self.scanManager = [QRCodeScanManager sharedManager];
    
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    [_scanManager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    
    __weak __typeof(self)weakSelf = self;
    //光扫描结果回调
    [_scanManager scanResult:^(NSArray *metadataObjects) {
        if (metadataObjects != nil && metadataObjects.count > 0) {
            [weakSelf.scanManager playSoundName:@"sound.caf"];
            //obj 为扫描结果
            [self stopScan];//为防止 重复识别二维码 多次跳转界面
            AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
            NSString *url = [obj stringValue];
            NSLog(@"---url = :%@", url);
            
            [weakSelf pushWebView:url];
        } else {
            NSLog(@"暂未识别出扫描的二维码");
        }
    }];
    
    //光纤变化回调
    [_scanManager brightnessChange:^(CGFloat brightness) {
        [weakSelf.scanView lightBtnChangeWithBrightnessValue:brightness];
    }];
    
}

- (UIView *)topContainer {
    if (!_topContainer) {
        _topContainer = [[UIView alloc] initWithFrame:self.view.bounds];
        _topContainer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _topContainer;
}

-(QRCodeScanView *)scanView{
    if (!_scanView) {
        _scanView =[[QRCodeScanView alloc]initWithFrame:CGRectMake(scanBorderX, scanBorderY, scanBorderW, scanBorderW)];
    }
    return _scanView;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scanView.frame) +50, Device_Width, 20)];
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.text = @"将二维码放入框内，即可自动扫描";
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.backgroundColor = [UIColor clearColor];
    }
    return _promptLabel;
}

- (QRScanBottomView *)bottomBtnView {
    if (!_bottomBtnView) {
        _bottomBtnView = [[QRScanBottomView alloc] initWithFrame:CGRectMake(0, Device_Height - 100, Device_Width, 100) showType:ShowTypeAlbum];
        _bottomBtnView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [_bottomBtnView.inputCodeBtn addTarget:self action:@selector(inputBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBtnView.albumBtn addTarget:self action:@selector(albumBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _bottomBtnView;
}


#pragma mark 底部按钮点击事件
- (void)inputBtnClick {
    NSLog(@"点击手动输入");
}
//借助第三方相册
- (void)albumBtnClick {
//    TZImagePickerController *pickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
//
//    __weak __typeof(self)weakSelf = self;
//
//    [pickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        UIImage *image = photos[0];
//        // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
//        // 声明一个 CIDetector，并设定识别类型 CIDetectorTypeQRCode
//        // 识别精度
//        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
//
//        //取得识别结果
//        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
//
//        NSString *resultStr;
//        if (features.count == 0) {
//            NSLog(@"暂未识别出二维码");
//        } else {
//            for (int index = 0; index < [features count]; index++) {
//                CIQRCodeFeature *feature = [features objectAtIndex:index];
//                resultStr = feature.messageString;
//            }
//            NSLog(@"---url:%@", resultStr);
//        }
//    }];
//    [self presentViewController:pickerController animated:YES completion:nil];
}


#pragma mark 停止扫描
- (void)stopScan {
    [self.scanView removeTimer];
    [_scanManager stopRunning];
    [_scanManager cancelSampleBufferDelegate];
}

- (void)pushWebView:(NSString *)url{
    
    WebViewController *webView = [[WebViewController alloc]init];
    webView.urlStr = url;
    [self presentViewController:webView animated:YES completion:^{
//        [self dismissViewControllerAnimated:YES completion:nil];
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
