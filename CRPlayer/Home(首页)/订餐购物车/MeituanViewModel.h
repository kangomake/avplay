//
//  MeituanViewModel.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/11/11.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeituanViewModel : NSObject

+ (void)GetShopData:(void(^)(NSMutableArray * dataArray))shopDataBlock;

#pragma  mark - 计算价格
+ (double)GetTotalPrice:(NSMutableArray *)dataArray;

#pragma mark - 计算订单数据
+ (NSMutableArray *)storeOrders:(NSMutableDictionary *)dictionary OrderData:(NSMutableArray *)orderArray isAdded:(BOOL)added;

#pragma  mark - 计算数量
+(NSInteger) CountOthersWithorderData:(NSMutableArray *)ordersArray;

#pragma mark - 更新显示数据
+(NSMutableArray *)UpdateArray:(NSMutableArray *)dataArray atSelectDictionary:(NSMutableDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
