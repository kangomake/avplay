//
//  CRAdvertHeadView.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/9/27.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRAdvertHeadView.h"

#define kHomeHeadHeight 170
#define kScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight  ([UIScreen mainScreen].bounds.size.height)

@interface CRAdvertHeadView ()<UIScrollViewDelegate>{
    int _currentImageIndex;
    int _nextImageIndex;
    BOOL _isLocalImageArray;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIImageView *secondImageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CRAdvertHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeHeadHeight)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.contentMode = UIViewContentModeScaleAspectFill;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];

        //添加点击事件
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
//        [_scrollView addGestureRecognizer:tap];

        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth - 200) / 2, kHomeHeadHeight - 25, 200, 20)];
        pageControl.backgroundColor = [UIColor clearColor];
        if (@available(iOS 14.0, *)) {
            pageControl.backgroundStyle = UIPageControlBackgroundStyleMinimal;
        }
        pageControl.hidesForSinglePage = YES;
        pageControl.currentPage = 0;
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        self.pageControl = pageControl;
        [self addSubview:pageControl];
    }

    return self;
}


#pragma mark --UIScrollViewDelegate
// 减速完成(分页滑动是会减速的)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self endRollSrollViewWith:scrollView];
}

// 滑动动画结束 setContentOffset: animated:YES 动画结束调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self endRollSrollViewWith:scrollView];
}

//视图持续滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"x-%f,y-%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    [self ScrollWithParallaxAddImageViewWith:scrollView.contentOffset.x];
}

//结束滚动后,重置页面
- (void)endRollSrollViewWith:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x != kScreenWidth) {
        //更新当前图片下标
        _currentImageIndex = _nextImageIndex;
        //给第一张相框添加图片
        [self addNextImageWith:self.firstImageView WithImageIndex:_nextImageIndex];
        //让视图瞬间回到中间位置
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
        //        self.pageController.currentPage = _currentImageIndex;

        self.pageControl.currentPage = _currentImageIndex;
    }
}


- (void)ScrollWithParallaxAddImageViewWith:(float)offsetX {
    static float nextImageViewCenterX = 0.f;
    if (offsetX < kScreenWidth) {//从左往右
        nextImageViewCenterX = (kScreenWidth + offsetX) / 2;
        _nextImageIndex = _currentImageIndex - 1;
    } else if (offsetX > kScreenWidth) {//从右往左
        nextImageViewCenterX = (kScreenWidth * 3 + offsetX) / 2;
        _nextImageIndex = _currentImageIndex + 1;
    } else {
        nextImageViewCenterX = kScreenWidth / 2;
    }

    //这块是完成轮播的关键(比如有四张图片:一二三四,轮播的排列是这样的:四一二三四一)
    if (_nextImageIndex == -1) {
        _nextImageIndex = (int)self.imageArray.count - 1;
    } else if (_nextImageIndex == self.imageArray.count) {
        _nextImageIndex = 0;
    }
//    NSLog(@"nextImageIndex-%d",_nextImageIndex);
    //添加将要出现的图片
    [self addNextImageWith:self.secondImageView WithImageIndex:_nextImageIndex];
    //设置将要出现图片的中心点
    CGPoint center = CGPointMake(nextImageViewCenterX, (kHomeHeadHeight) / 2);
    self.secondImageView.center = center;
}

//给第一个相框/第二个相框添加图片
- (void)addNextImageWith:(UIImageView *)imageView WithImageIndex:(NSInteger)imageIndex;{
    if (_isLocalImageArray) {
        //添加将要出现视图的本地图片
        imageView.image = self.imageArray[imageIndex];
    } else {
        if (imageIndex < [self.imageArray count]) {
            //添加将要出现视图的网络图片
//            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[imageIndex]]];
        }
    }
}



@end
