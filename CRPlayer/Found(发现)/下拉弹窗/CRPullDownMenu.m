//
//  CRPullDownMenu.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/3/3.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRPullDownMenu.h"
#import "CRScreen.h"

#import "CRCover.h"
#import "CRMenuButton.h"
#import "CRMenuTableController.h"


static const CGFloat kMenuContentHeight = 300;

/**
 添加一个蒙版coverView到keyWindow上，它的位置coverY=CGRectGetMaxY(self.frame);
 高度是self.superview.bounds.size.height - coverY;
 
 在coverView上添加contenview，初始高度是零，点击按钮时高度增加到kMenuContentHeight
 
 
 */
@interface CRPullDownMenu ()

@property (nonatomic, strong) CRCover *coverView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *menuButtons;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *controllers;

@end


@implementation CRPullDownMenu


#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self reload];
    }
    return self;
}

//
- (NSMutableArray *)menuButtons{
    if (_menuButtons == nil) {
        _menuButtons = [NSMutableArray array];
    }
    return _menuButtons;
}

- (NSArray *)titleArray{
    if(!_titleArray){
        _titleArray = @[@"按职位查看",@"按状态查看"];
    }
    return  _titleArray;
}


- (UIView *)coverView{
    if (_coverView == nil) {
        
        // 设置蒙版的frame
        CGFloat coverX = 0;
        CGFloat coverY = CGRectGetMaxY(self.frame);
        CGFloat coverW = kScreenWidth;

        CGFloat coverH = self.superview.bounds.size.height - coverY;
        _coverView = [[CRCover alloc] initWithFrame:CGRectMake(coverX, coverY, coverW, coverH)];
        _coverView.backgroundColor = RGBA(200, 200, 200, 0.9);
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:_coverView];
        
//        [self.superview addSubview:_coverView];
       
        // Cover 的 Block
        __weak typeof(self) weakSelf = self;
        _coverView.clickCover = ^{ // 点击蒙版调用
            [weakSelf dismiss];
        };
    }
    return _coverView;
}

- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.frame = CGRectMake(0, 0, kScreenWidth, 0);
        _contentView.clipsToBounds = YES;
        [self.coverView addSubview:_contentView];
    }
    return _contentView;
}


- (NSMutableArray *)controllers{
    if (_controllers == nil) {
        _controllers = [NSMutableArray array];
    }
    return _controllers;
}


- (void)ConfigChildViewControllers:(NSMutableArray *)controllerArray{
    self.controllers = controllerArray;
}


// 初始化控件
- (void)setup{
    
    self.backgroundColor =RGB(249, 249, 249);
    
//    _separateLineTopMargin = 10;
//
//    _separateLineColor = [UIColor clearColor];
//
//    _coverColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1];
    
    // 监听通知 隐藏下拉菜单
//    _observer = [[NSNotificationCenter defaultCenter] addObserverForName:YZUpdateMenuTitleNote object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//
//        NSLog(@"note.userInfo-%@,note.objecct-%@",note.userInfo,note.object);
//        // 获取列
////        NSInteger col = [self.controllers indexOfObject:note.object];
////        NSLog(@"col-%ld",col);
//
//        NSDictionary * dic = note.userInfo;
//        NSInteger col = [[dic valueForKey:@"index"] integerValue];
//        NSString * titleKey = [dic valueForKey:@"titleKey"];
//        // 获取对应按钮
//        UIButton *btn = self.menuButtons[col];
//        btn.titleLabel.font = [UIFont systemFontOfSize:14];
//
//        // 隐藏下拉菜单
//        [self dismiss];
//
//
//
//
//        // 设置按钮标题
//        [btn setTitle:titleKey forState:UIControlStateNormal];
//
//    }];
    
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:YZUpdateMenuTitleNoteCancel object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//        // 隐藏下拉菜单
//        [self dismiss];
//
//    }];
    
}

#pragma mark - 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 布局子控件
    NSInteger count = self.menuButtons.count;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.bounds.size.width / count - 10;
    CGFloat btnH = self.bounds.size.height;

    for (NSInteger i = 0; i < count; i++) {
        // 设置按钮位置
        UIButton *btn = self.menuButtons[i];
        btnX = i * (self.bounds.size.width / count) + 5;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];//add
        
        // 设置分割线位置
//        if (i < count - 1) {
//            UIView *separateLine = self.separateLines[i];
//            separateLine.frame = CGRectMake(CGRectGetMaxX(btn.frame), _separateLineTopMargin, 1, btnH - 2 * _separateLineTopMargin);
//        }
    }
    
    // 设置底部View位置
//    CGFloat bottomH = 0.8;
//    CGFloat bottomY = btnH - bottomH;
//    _bottomLine.frame = CGRectMake(0, bottomY, self.bounds.size.width, bottomH);
}


#pragma mark - 即将进入窗口
- (void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    
//    [self reload];
}

#pragma mark - 下拉菜单功能
// 删除之前所有数据,移除之前所有子控件
- (void)clear{
    self.coverView = nil;
    self.contentView = nil;
    [self.menuButtons removeAllObjects];
//    [self.controllers removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


// 刷新下拉菜单
- (void)reload{
    // 删除之前所有数据,移除之前所有子控件
    [self clear];

    // 获取有多少列
    NSInteger cols = 2;

    // 添加按钮
    for (NSInteger col = 0; col < cols; col++) {
        
        // 获取按钮
        UIButton *menuButton = [self pullDownMenu:self buttonForColAtIndex:col];
        menuButton.tag = col;
        [menuButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (menuButton == nil) {
            @throw [NSException exceptionWithName:@"YZError" reason:@"pullDownMenu:buttonForColAtIndex:这个方法不能返回空的按钮）" userInfo:nil];
            return;
        }
        [self addSubview:menuButton];
        // 添加按钮
        [self.menuButtons addObject:menuButton];

        // 保存所有子控制器
//        UIViewController *vc = [self.dataSource pullDownMenu:self viewControllerForColAtIndex:col];
//        [self.controllers addObject:vc];
        
        
        
    }
    

    
    // 设置所有子控件的尺寸
    [self layoutSubviews];

}

#pragma mark - 点击菜单标题按钮
- (void)btnClick:(UIButton *)button{
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"registerTextField" object:nil];
    button.selected = !button.selected;
    
    // 取消其他按钮选中
    for (UIButton *otherButton in self.menuButtons) {
        if (otherButton == button) continue;
        otherButton.selected = NO;
    }
    
    if (button.selected == YES) { // 当按钮选中，弹出蒙版
        // 添加对应蒙版
        
        // 获取角标
        NSInteger i = button.tag;
        
        // 移除之前子控制器的View
        [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        // 添加对应子控制器的view
        UIViewController *vc = self.controllers[i];
        vc.view.frame = self.contentView.bounds;
        [self.contentView addSubview:vc.view];

        // 设置内容的高度
//        CGFloat height = [self.colsHeight[i] floatValue];
        
        [UIView animateWithDuration:0.4 animations:^{

            self.coverView.hidden = NO;

            
            CGRect frame = self.contentView.frame;
            frame.size.height = kMenuContentHeight;
            self.contentView.frame = frame;

            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10,10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.contentView.bounds;
            maskLayer.path = maskPath.CGPath;
            self.contentView.layer.mask = maskLayer;


        } ];
        
//        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//
//            CGRect frame = self.contentView.frame;
//            frame.size.height = kMenuContentHeight;
//            self.contentView.frame = frame;
//
//            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10,10)];
//            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//            maskLayer.frame = self.contentView.bounds;
//            maskLayer.path = maskPath.CGPath;
//            self.contentView.layer.mask = maskLayer;
//
//        } completion:nil];
        
        
        
        
        
        
        
    } else { // 当按钮未选中，收回蒙版
        [self dismiss];
    }
}

- (void)dismiss{
    // 所有按钮取消选中
    for (UIButton *button in self.menuButtons) {
        button.selected = NO;
    }
    
    // 移除蒙版
    self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.contentView.frame;
        frame.size.height = 0;
        self.contentView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        self.coverView.hidden = YES;
        self.coverView.backgroundColor = RGBA(200, 200, 200, 0.9);
        
    }];
}


#pragma mark --datasource

// 返回下拉菜单每列按钮
- (UIButton *)pullDownMenu:(CRPullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index{
    CRMenuButton *button = [CRMenuButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [button setTitle:self.titleArray[index] forState:UIControlStateNormal];
    [button setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"arrow_down@2x.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"arrow_up@2x.png"] forState:UIControlStateSelected];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2);
    return button;
}

// 返回下拉菜单每列对应的控制器
//- (UIViewController *)pullDownMenu:(CRPullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index{
//    return self.childViewControllers[index];
//}


#pragma mark - 界面销毁
- (void)dealloc{
    [self clear];
//    [[NSNotificationCenter defaultCenter] removeObserver:_observer];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
