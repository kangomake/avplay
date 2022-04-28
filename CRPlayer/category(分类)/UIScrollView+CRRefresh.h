//
//  UIScrollView+CRRefresh.h
//  CRPlayer
//
//  Created by appleDeveloper on 2022/3/22.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (CRRefresh)

// 设置下拉刷新 (如果需要上拉和下拉,用(MKUITableView+LGRefresh.h 的setRefreshBlock))
- (void)setHeaderRefresh:(void (^)(void))refreshBlock;

// 结束刷新
- (void)mk_endRefreshing;

@end

NS_ASSUME_NONNULL_END
