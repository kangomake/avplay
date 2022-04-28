//
//  UIScrollView+CRRefresh.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/3/22.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "UIScrollView+CRRefresh.h"

@implementation UIScrollView (CRRefresh)

// 设置下拉刷新 (如果需要上拉和下拉,用(MKUITableView+LGRefresh.h 的setRefreshBlock))
- (void)setHeaderRefresh:(void (^)(void))refreshBlock{
    MJRefreshNormalHeader *headerHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshBlock];
    headerHeader.stateLabel.hidden = YES;
    [headerHeader setTitle:@"" forState:MJRefreshStateIdle];
    headerHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = headerHeader;
}

// 结束刷新
- (void)mk_endRefreshing{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

@end
