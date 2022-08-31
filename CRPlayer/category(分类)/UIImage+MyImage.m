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

/**
图片修改颜色
*/
-(UIImage*)imageChangeColor:(UIColor*)color{
    
    
    UIImage *newImage = nil;
    CGRect imageRect = (CGRect){CGPointZero,self.size};
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -(imageRect.size.height));
    CGContextClipToMask(context, imageRect, self.CGImage);//选中选区 获取不透明区域路径
    CGContextSetFillColorWithColor(context, color.CGColor);//设置颜色
    CGContextFillRect(context, imageRect);//绘制
    newImage = UIGraphicsGetImageFromCurrentImageContext();//提取图片
    UIGraphicsEndImageContext();
    return newImage;
    
    
//    //获取画布
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
//    //画笔沾取颜色
//    [color setFill];
//
//    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
//    UIRectFill(bounds);
//    //绘制一次
//    [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:0.8f];
//    //再绘制一次
//    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:0.8f];
//    //获取图片
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
    
}



@end
