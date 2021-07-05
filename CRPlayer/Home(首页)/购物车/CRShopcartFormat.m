//
//  CRShopcartFormat.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/28.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRShopcartFormat.h"

@interface CRShopcartFormat ()

@property (nonatomic, strong) NSMutableArray *shopcartListArray;

@end


@implementation CRShopcartFormat

- (void)requestShopcartProductList{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shopcart" ofType:@"plist"];
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
//    self.shopcartListArray = dataArray;
    
}

@end
