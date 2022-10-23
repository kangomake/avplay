//
//  keychainManager.h
//  CRPlayer
//
//  Created by appleDeveloper on 2022/4/11.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface keychainManager : NSObject

//保存数据
+ (BOOL)SaveData:(id)aData withAccountIdentifier:(NSString *)accountId andServiceIdentifier:(NSString *)serviceId;

//获取数据
+ (id)GetDataWithAccountIdentifier:(NSString *)accountId andServiceIdentifier:(NSString *)serviceId;

//更新数据
+ (BOOL)UpdataData:(id)data withAccountIdentifier:(NSString *)accountId andServiceIdentifier:(NSString *)serviceId;

//删除数据
+ (void)DeleteWithAccountIdentifier:(NSString *)accountId andServiceIdentifier:(NSString *)serviceId;

@end

NS_ASSUME_NONNULL_END
