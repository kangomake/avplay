//
//  CRShopcartTableViewProxy.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/26.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



typedef void(^ShopcartProxyProductSelectBlock)(BOOL isSelected, NSIndexPath *indexPath);
typedef void(^ShopcartProxyBrandSelectBlock)(BOOL isSelected,NSInteger section);
typedef void(^ShopcartProxyChangeCountBlock)(NSInteger count, NSIndexPath *indexPath);
typedef void(^ShopcartProxyDeleteBlock)(NSIndexPath *indexPath);
typedef void(^ShopcartProxyStarBlock)(NSIndexPath *indexPath);


@interface CRShopcartTableViewProxy : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy)ShopcartProxyProductSelectBlock ProxyProductSelectBlock;
@property (nonatomic, copy)ShopcartProxyBrandSelectBlock ProxyBrandSelectBlock;
@property (nonatomic, copy)ShopcartProxyChangeCountBlock ProxyChangeCountBlock;
@property (nonatomic, copy)ShopcartProxyDeleteBlock ProxyDeleteBlock;
@property (nonatomic, copy)ShopcartProxyStarBlock  ProxyStarBlock;

@end

NS_ASSUME_NONNULL_END
