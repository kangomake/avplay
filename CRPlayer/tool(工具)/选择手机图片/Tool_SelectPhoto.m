//
//  Tool_SelectPhoto.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/10/13.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "Tool_SelectPhoto.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import <Photos/Photos.h>
#import <TZImagePickerController.h>



@interface Tool_SelectPhoto ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) Tool_SelectPhotoSelectBlock selectBlock;

@end

@implementation Tool_SelectPhoto

//=======单例
+ (instancetype)shareSelectPhotoManager {
    static Tool_SelectPhoto *_shareSelectPhotoManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareSelectPhotoManager = [[Tool_SelectPhoto alloc]init];
    });

    return _shareSelectPhotoManager;
}

- (void)goToSelcetPhotoWithMaxImagesCount:(NSInteger)imagesCount
                           selectedAssets:(NSMutableArray *)selectedAssets
                                  superVC:(UIViewController *)superVC
                              selectBlock:(void(^)(NSArray *photos,NSArray *assets))selectBlock{
    self.selectBlock = selectBlock;

    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc]initWithMaxImagesCount:imagesCount columnNumber:3 delegate:nil pushPhotoPickerVc:YES];

    imagePickerVC.allowPickingOriginalPhoto = NO;
    imagePickerVC.allowPickingVideo = NO;
    imagePickerVC.allowTakeVideo = NO;
    imagePickerVC.selectedAssets = selectedAssets;
//    _imagePickerVC.allowTakePicture=NO;

    [superVC presentViewController:imagePickerVC animated:YES completion:nil];

    __weak typeof(self) weakSelf = self;
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        weakSelf.selectBlock(photos, assets);
    }];
}

//去拍摄照片
- (void)goToTakePictureWithSuperVC:(UIViewController *)superVC
                       selectBlock:(Tool_SelectPhotoSelectBlock)selectBlock{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        
        // 无相机权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        
        [superVC presentViewController:alertController animated:YES completion:nil];
        
        
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
            if (granted) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self goToTakePictureWithSuperVC:superVC selectBlock:selectBlock];
                });
            }
        }];
        
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) {
        
        // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        
        [superVC presentViewController:alertController animated:YES completion:nil];
        
    } else if ([PHPhotoLibrary authorizationStatus] == 0) {
        
        // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self goToTakePictureWithSuperVC:superVC selectBlock:selectBlock];
        }];
        
    } else {
        
        [self pushImagePickerController:superVC selectBlock:selectBlock];
    }
    
}

- (void)pushImagePickerController:(UIViewController *)superVC
                      selectBlock:(Tool_SelectPhotoSelectBlock)selectBlock{
    
    
    self.selectBlock=selectBlock;
    
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [superVC presentViewController:picker animated:YES completion:nil];
    
}





// 获取图片后操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //通过key值获取到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (image==nil) {
        
//        [SVProgressHUD showInfoWithStatus:@"获取图片失败"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [[TZImageManager manager] savePhotoWithImage:[info objectForKey:UIImagePickerControllerOriginalImage] meta:[info objectForKey:UIImagePickerControllerMediaMetadata] location:nil completion:^(PHAsset *asset, NSError *error) {
//
//
        TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
//
        weakSelf.selectBlock(@[image], @[assetModel.asset]);
    }];
    
    
}



//调用第三方去预览选择好的照片
-(void)lookSelectPhotoWithSuperVC:(UIViewController *)superVC
                   selectedPhotos:(NSMutableArray *)selectedPhotos
                   selectedAssets:(NSMutableArray *)selectedAssets
                      selectIndex:(NSInteger)index{
    
    id asset = selectedAssets[index];
    BOOL isVideo = NO;
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        
        PHAsset *phAsset = asset;
        isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
    }
    
    if ([[asset valueForKey:@"filename"] containsString:@"GIF"]) {
        
        TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
        TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
        vc.model = model;

        [superVC presentViewController:vc animated:YES completion:nil];
        
    } else if (isVideo) { // perview video / 预览视频
        
        TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
        TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
        vc.model = model;

        [superVC presentViewController:vc animated:YES completion:nil];
        
    } else { // preview photos / 预览照片
        
        TZImagePickerController *vc = [[TZImagePickerController alloc] initWithSelectedAssets:selectedAssets selectedPhotos:selectedPhotos index:index];
        [superVC presentViewController:vc animated:YES completion:nil];
        
    }
    
}


@end
