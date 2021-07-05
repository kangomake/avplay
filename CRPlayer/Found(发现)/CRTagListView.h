//
//  CRTagListView.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/1.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRTagListView : UIView

/**
 *  标签删除图片
 */
@property (nonatomic, strong) UIImage *tagDeleteimage;

/**
 *  标签间距,和距离左，上间距,默认10
 */
@property (nonatomic, assign) CGFloat tagMargin;

/**
 *  标签颜色，默认红色
 */
@property (nonatomic, strong) UIColor *tagColor;

/**
 *  标签背景颜色
 */
@property (nonatomic, strong) UIColor *tagBackgroundColor;

/**
 *  标签背景图片
 */
@property (nonatomic, strong) UIImage *tagBackgroundImage;

/**
 *  标签字体，默认13
 */
@property (nonatomic, assign) UIFont *tagFont;

/**
 *  标签按钮内容间距，标签内容距离左上下右间距，默认5
 */
@property (nonatomic, assign) CGFloat tagButtonMargin;

/**
 *  标签圆角半径,默认为5
 */
@property (nonatomic, assign) CGFloat tagCornerRadius;

/**
 *  标签列表的高度
 */
@property (nonatomic, assign) CGFloat tagListH;

/**
 *  边框宽度
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 *  边框颜色
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 *  获取所有标签
 */
@property (nonatomic, strong, readonly) NSMutableArray *tagArray;


/**
 *  是否需要自定义tagList高度，默认为Yes
 */
@property (nonatomic, assign) BOOL isFitTagListH;


/******自定义标签尺寸******/
//@property (nonatomic, assign) CGSize tagSize;

/******标签列表总列数 默认4列******/
/**
 *  标签间距会自动计算
 */
@property (nonatomic, assign) NSInteger tagListCols;






//*********************************** Public Method ****************************************//

/**
 *  添加标签
 *
 *  @param tagStr 标签文字
 */
//- (void)addTag:(NSString *)tagStr;

/**
 *  添加多个标签
 *
 *  @param tagStrs 标签数组，数组存放（NSString *）
 */
- (void)addTags:(NSArray *)tagStrs;

/**
 *  删除标签
 *
 *  @param tagStr 标签文字
 */

//- (void)deleteTag:(NSString *)tagStr;



- (void)removeAllTag;//移除所有的tag


/**
 *  点击标签，执行Block
 */
//@property (nonatomic, strong) void(^clickTagBlock)(NSString *tag);

@end

NS_ASSUME_NONNULL_END
