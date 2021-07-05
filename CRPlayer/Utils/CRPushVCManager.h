//
//  CRPushVCManager.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/23.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRPushVCManager : NSObject

/*
示例:
  这个规则肯定事先跟服务端沟通好，跳转对应的界面需要对应的参数
   NSDictionary *userInfo = @{
                           @"class": @"HSFeedsViewController",
                           @"property": @{
                                        @"ID": @"123",
                                        @"type": @"12"
                                   }
                           };
    
    [self push:userInfo];

**/


+ (void)push:(NSDictionary *)params controller:(UIViewController *)controller;


@end

NS_ASSUME_NONNULL_END
