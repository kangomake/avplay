//
//  CRScreen.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/6/16.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRScreen.h"

@implementation CRScreen

+ (CGSize)sizeFor65Inch{
    return CGSizeMake(414,896);
}

//iphone xr
+ (CGSize)sizeFor61Inch{
    return CGSizeMake(414,896);
}

// iphonex
+ (CGSize)sizeFor58Inch{
    return CGSizeMake(375,812);
}


//根据不同系统，通过相应方法获取状态栏高度。
+ (CGFloat)statusBarHeight {
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        statusBarHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

@end
