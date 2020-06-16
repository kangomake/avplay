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

@end
