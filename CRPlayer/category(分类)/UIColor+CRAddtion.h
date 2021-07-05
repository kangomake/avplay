//
//  UIColor+CRAddtion.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/10/26.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CRAddtion)

+ (instancetype)ColorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(CGFloat)alpha;

+ (instancetype)ColorWithHex:(uint32_t)hex alpha:(CGFloat)alpha;

+(instancetype)RandomColor;

@end

NS_ASSUME_NONNULL_END
