//
//  UIImage+MyImage.h
//  CRPlayer
//
//  Created by appleDeveloper on 2021/10/14.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MyImage)

//当前屏幕渲染 实现圆角 提高性能
- (UIImage *)imageWIthCornerRadius:(CGFloat)radius ofSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
