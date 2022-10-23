//
//  CRCicleGifHeader.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/10/23.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRCicleGifHeader.h"

@implementation CRCicleGifHeader

- (void)prepare{
    [super prepare];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
    
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=23; i++) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"loading_000%zd@3x", i] ofType:@"png"];
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_00%zd", i]];
        [idleImages addObject:image];
    }
     [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=23; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_00%zd", i]];
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"loading_000%zd@3x", i] ofType:@"png"];
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
