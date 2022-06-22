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


#pragma mark --获取系统的一些高度

/// 顶部安全区高度
+ (CGFloat)safeDistanceTop {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}

/// 底部安全区高度
+ (CGFloat)safeDistanceBottom {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}


/// 顶部状态栏高度（包括安全区）
//+ (CGFloat)statusBarHeight {
//    if (@available(iOS 13.0, *)) {
//        NSSet *set = [UIApplication sharedApplication].connectedScenes;
//        UIWindowScene *windowScene = [set anyObject];
//        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
//        return statusBarManager.statusBarFrame.size.height;
//    } else {
//        return [UIApplication sharedApplication].statusBarFrame.size.height;
//    }
//}

/// 导航栏高度
+ (CGFloat)navigationBarHeight {
    return 44.0f;
}

/// 状态栏+导航栏的高度
+ (CGFloat)navigationFullHeight {
    return [self statusBarHeight] + [self navigationBarHeight];
}

/// 底部导航栏高度
+ (CGFloat)tabBarHeight {
    return 49.0f;
}

/// 底部导航栏高度（包括安全区）
+ (CGFloat)tabBarFullHeight {
    return [self statusBarHeight] + [self safeDistanceBottom];
}


@end
