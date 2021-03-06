//
//  UIColor+CRAddtion.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/10/26.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "UIColor+CRAddtion.h"

//#import <AppKit/AppKit.h>


@implementation UIColor (CRAddtion)

+ (instancetype)ColorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (instancetype)ColorWithHex:(uint32_t)hex alpha:(CGFloat)alpha {
    uint8_t red = (hex & 0xff0000) >> 16;
    uint8_t green = (hex & 0x00ff00) >> 8;
    uint8_t blue = hex & 0x0000ff;
    return [self ColorWithRed:red green:green blue:blue alpha:alpha];
}

+ (instancetype)RandomColor {
    return [UIColor ColorWithRed:arc4random_uniform(256) green:arc4random_uniform(256) blue:arc4random_uniform(256) alpha:1.0];
}

@end
