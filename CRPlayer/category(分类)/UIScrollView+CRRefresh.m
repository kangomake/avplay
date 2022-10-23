//
//  UIScrollView+CRRefresh.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/3/22.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "UIScrollView+CRRefresh.h"
#import "CRMyNormalHeader.h"
#import "CRWaveLoadingHeader.h"
#import "CRCicleGifHeader.h"

@implementation UIScrollView (CRRefresh)

// 设置下拉刷新 (如果需要上拉和下拉,用(MKUITableView+LGRefresh.h 的setRefreshBlock))
- (void)setHeaderRefresh:(void (^)(void))refreshBlock{

    //方案一 默认的
//    MJRefreshNormalHeader *NormalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshBlock];
//    NormalHeader.stateLabel.hidden = YES;
//    [NormalHeader setTitle:@"" forState:MJRefreshStateIdle];
//    NormalHeader.lastUpdatedTimeLabel.hidden = YES;
//    self.mj_header = NormalHeader;

    
    //方案二 自定义CRMyNormalHeader 继承于MJRefreshHeader
//    CRMyNormalHeader *myHeader = [CRMyNormalHeader headerWithRefreshingBlock:refreshBlock];
//    self.mj_header = myHeader;

    //加载动画 下拉刷新
//    CRWaveLoadingHeader *loadHeader = [CRWaveLoadingHeader headerWithRefreshingBlock:refreshBlock];
//    self.mj_header = loadHeader;
    
    //转圈动画
    CRCicleGifHeader *gifHeader = [CRCicleGifHeader headerWithRefreshingBlock:refreshBlock];
    self.mj_header = gifHeader;
    
    
    //方案三 是用了KafkaRefresh
//    [self bindHeadRefreshHandler:refreshBlock themeColor:UIColor.orangeColor refreshStyle:KafkaRefreshStyleNative];
    
    
    
}

//开始刷新
- (void)mk_beginRefreshing{
    [self.mj_header beginRefreshing];
}


// 结束刷新
- (void)mk_endRefreshing{
    //方案一 基于MJRefresh
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    
    
    //方案二 基于KafkaRefresh
    [self.headRefreshControl endRefreshingWithAlertText:@"推荐职位已刷新" completion:nil];
}

@end
