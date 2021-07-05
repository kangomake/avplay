//
//  CRNotificationManager.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/17.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRNotificationManager.h"
#import <UIKit/UIKit.h>

@interface CRNotificationManager ()<UNUserNotificationCenterDelegate>

@end


@implementation CRNotificationManager


+ (CRNotificationManager *)notificationManager{
    
    static CRNotificationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CRNotificationManager alloc]init];
    });
    return manager;
    
}


- (void)registerNotification{
    
    if (@available(iOS 10.0, *)) {
        UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if(granted){// 允许授权
                //本地推送
//                [self addNotification];
                
                //远程推送
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [[UIApplication sharedApplication] registerForRemoteNotifications];
//                });
                
                
                
            }else{// 不允许授权
                
            }
            
        }];
        
        // 获取用户对通知的设置
        // 通过settings.authorizationStatus 来处理用户没有打开通知授权的情况
        [UNUserNotificationCenter.currentNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            NSLog(@"%@",settings);
            
        }];
        
        
    } else {
        // Fallback on earlier versions
    }
    
}


#pragma  mark -- UNUserNotificationCenterDelegate
// 在前台时 收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
    
}

// 点击通知，从后台进入前台
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSString *identifier = response.actionIdentifier;
    
    if([identifier isEqualToString:@"open"]){
        
    }else if ([identifier isEqualToString:@"close"]){
        
    }
    completionHandler();
    
    
}


- (void)addNotification{
    
    if (@available(iOS 10.0, *)) {
        
        // 创建一个通知内容
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
        content.badge = @1;
        content.title = @"新消息";
//        content.subtitle = @"subtitle";
        content.body = @"body";
        content.sound = [UNNotificationSound defaultSound];
//        content.categoryIdentifier = @"category";

        // 通知触发器
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:false];
        // 通知请求
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"_pushLocalNotification" content:content trigger:trigger];
        
        //添加通知
        [UNUserNotificationCenter.currentNotificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"error--%@",error);
        }];
        
        
        // 添加通知的一些操作
        UNNotificationAction *openAction = [UNNotificationAction actionWithIdentifier:@"open" title:@"open" options:UNNotificationActionOptionForeground];
        UNNotificationAction *closeAction = [UNNotificationAction actionWithIdentifier:@"close" title:@"close" options:UNNotificationActionOptionDestructive];
        
        UNNotificationCategory *Category = [UNNotificationCategory categoryWithIdentifier:@"category" actions:@[openAction,closeAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        
        
        NSSet *sets = [NSSet setWithObject:Category];
        [UNUserNotificationCenter.currentNotificationCenter setNotificationCategories:sets];
        
        
        
    } else {
        // Fallback on earlier versions
    }
    
   
    
}

- (void)removeNotification{
    
    if (@available(iOS 10.0, *)) {
        // 移除 待处理的通知
        [UNUserNotificationCenter.currentNotificationCenter removePendingNotificationRequestsWithIdentifiers:@[@"_pushLocalNotification"]];
         // 移除 已经处理的通知
        [UNUserNotificationCenter.currentNotificationCenter removeDeliveredNotificationsWithIdentifiers:@[@"_pushLocalNotification"]];
        
        // 移除所有的通知
        [UNUserNotificationCenter.currentNotificationCenter removeAllDeliveredNotifications];
        [UNUserNotificationCenter.currentNotificationCenter removeAllPendingNotificationRequests];
        
        
    } else {
        // Fallback on earlier versions
    }

    
}



@end
