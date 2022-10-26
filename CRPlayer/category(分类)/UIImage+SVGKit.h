//
//  UIImage+SVGKit.h
//  hr_renzheng
//
//  Created by appleDeveloper on 2021/6/10.
//

#import <UIKit/UIKit.h>
#import <SVGKImage.h>

NS_ASSUME_NONNULL_BEGIN

/**
 使用示例
 UIImageView *ivCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
 ivCover.image = [UIImage svgImageNamed:@"中国结.svg" imgv:ivCover];
 [self.view addSubview ivCover];
 */




//加载svg格式图片
@interface UIImage (SVGKit)

/// 单纯加载svg图片
/// @param name 图片名
/// @param imgv 显示的UIImageView
+(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv;

/// 加载svg图片，用16进制色值修改颜色
/// @param name 图片名
/// @param imgv 显示的UIImageView
/// @param hexColor 16进制色值
+(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv hexColor:(NSString *)hexColor;

/// 加载svg图片，用色值对象修改颜色
/// @param name 图片名
/// @param imgv 显示的UIImageView
/// @param objColor 色值对象
+(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv objColor:(UIColor *)objColor;

@end

NS_ASSUME_NONNULL_END
