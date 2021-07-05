//
//  CRNotificationManager.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/17.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>


NS_ASSUME_NONNULL_BEGIN
/**
APP 推送管理
*/
@interface CRNotificationManager : NSObject

+ (CRNotificationManager *)notificationManager;

- (void)registerNotification;

- (void)addNotification;

@end

NS_ASSUME_NONNULL_END
