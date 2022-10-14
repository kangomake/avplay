//
//  Tool_SelectPhoto.h
//  CRPlayer
//
//  Created by appleDeveloper on 2022/10/13.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

//选择后的回调
typedef void(^Tool_SelectPhotoSelectBlock)(NSArray *photos,NSArray *assets);

/**
 手机相册选择图片工具
 */
@interface Tool_SelectPhoto : NSObject

//单例
+(instancetype)shareSelectPhotoManager;

//去相册选择照片
- (void)goToSelcetPhotoWithMaxImagesCount:(NSInteger)imagesCount
                           selectedAssets:(NSMutableArray *)selectedAssets
                                  superVC:(UIViewController *)superVC
                              selectBlock:(Tool_SelectPhotoSelectBlock)selectBlock;
//去拍摄照片
- (void)goToTakePictureWithSuperVC:(UIViewController *)superVC
                      selectBlock:(Tool_SelectPhotoSelectBlock)selectBlock;



//去预览选择好的照片
-(void)lookSelectPhotoWithSuperVC:(UIViewController *)superVC
                   selectedPhotos:(NSMutableArray *)selectedPhotos
                   selectedAssets:(NSMutableArray *)selectedAssets
                      selectIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
