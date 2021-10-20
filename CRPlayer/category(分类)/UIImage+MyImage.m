//
//  UIImage+MyImage.m
//  CRPlayer
//
//  Created by appleDeveloper on 2021/10/14.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import "UIImage+MyImage.h"

@implementation UIImage (MyImage)

//当前屏幕渲染 实现圆角 提高性能
- (UIImage *)imageWIthCornerRadius:(CGFloat)radius ofSize:(CGSize)size{
    //当前uiimage 的可见绘制区域
    CGRect rect = (CGRect){0.f,0.f,size};
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
