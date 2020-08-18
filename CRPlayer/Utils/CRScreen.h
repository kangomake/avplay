//
//  CRScreen.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/6/16.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



#define IS_LANDSCAPE (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))

//#define SCREEN_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen ] bounds].size.height : [[UIScreen mainScreen ] bounds].size.width)
//#define SCREEN_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen ] bounds].size.width : [[UIScreen mainScreen ] bounds].size.height)


#define SCREEN_WIDTH ([[UIScreen mainScreen ] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen ] bounds].size.height)

// 当前屏幕宽/高
#define kScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight  ([UIScreen mainScreen].bounds.size.height)


//#define kNaviHeight (IS_IPHONE_X_XR_MAX ? 88 : 64)
//#define kStatusBarHeight  (IS_IPHONE_X_XR_MAX ? 44 : 20)
//#define kTabbarHeight (IS_IPHONE_X_XR_MAX ? 83 : 49)
//#define kBottomHeight (IS_IPHONE_X_XR_MAX ? 34 : 0)



#define IS_IPHONE_X_XR_MAX (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XMAX)

#define IS_IPHONE_X (SCREEN_WIDTH == [GTScreen sizeFor58Inch].width && SCREEN_HEIGHT == [GTScreen sizeFor58Inch].height)
#define IS_IPHONE_XR (SCREEN_WIDTH == [GTScreen sizeFor61Inch].width && SCREEN_HEIGHT == [GTScreen sizeFor61Inch].height && [UIScreen mainScreen].scale == 2)
#define IS_IPHONE_XMAX (SCREEN_WIDTH == [GTScreen sizeFor65Inch].width && SCREEN_HEIGHT == [GTScreen sizeFor65Inch].height && [UIScreen mainScreen].scale == 3)

#define STATUSBARHEIGHT (IS_IPHONE_X_XR_MAX ? 44 : 20)

#define UI(x) UIAdapter(x)
#define UIRect(x,y,width,height) UIRectAdapter(x,y,width,height)

#define RGB(r,g,b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]





static inline NSInteger UIAdapter (float x){
    
    CGFloat scale = 414 / SCREEN_WIDTH;
    return (NSInteger)x /scale;
    
}

//...
static inline CGRect UIRectAdapter(x,y,width,height){
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
}


@interface CRScreen : NSObject

//iphone xs max
+ (CGSize)sizeFor65Inch;

//iphone xr
+ (CGSize)sizeFor61Inch;

// iphonex
+ (CGSize)sizeFor58Inch;

//...其它机型

@end

NS_ASSUME_NONNULL_END
