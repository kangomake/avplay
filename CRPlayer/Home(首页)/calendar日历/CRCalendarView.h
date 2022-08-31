//
//  CRCalendarView.h
//  CRPlayer
//
//  Created by appleDeveloper on 2022/8/16.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CRCalendarDateModel;

typedef  void(^calendarSelectDateBlock)(NSMutableArray *selectDatesArrayM);

@interface CRCalendarView : UIView

//已选中的日期,传入，就会显示已经选中的
@property(nonatomic,strong)NSMutableArray *selectDatesArrayM;

//点击确定返回block
@property(nonatomic,copy)calendarSelectDateBlock selectBlock;

//账单日
@property(nonatomic,copy)NSString *billDay;
//还款日
@property(nonatomic,copy)NSString *repaymentDay;

//今天是否可以选择，默认是可以
@property(nonatomic,assign)BOOL isCanSelectToday;

//可以选择的最大日期差。从今天开始算起，今天第0天,默认25天间隔,==0，则不限制选择时间
@property(nonatomic,assign)NSInteger maxSelectDateDifference;
//可以选择最多的天数，默认最多选择25天
@property(nonatomic,assign)NSInteger canSelectMostDate;
//当选择达到个数，直接消失自己，默认NO
@property(nonatomic,assign)BOOL whenChoiceReachesNumberDisappearSelf;
//是否全部日期可以选择，设置了这个，其他的设置都将无效，默认NO
@property(nonatomic,assign)BOOL isCanSelectAllDays;
//不能选择未来日期（今天可选），默认NO
@property(nonatomic,assign)BOOL canNotSelectFutureDate;
//当回调后，是否清除已选中的日期，默认NO
@property(nonatomic,assign)BOOL whenSelectBlockToClearSelectDatesArrM;

/*
 是否强制只能在账单日和还款日之间选择。
 如果这个设置YES，maxSelectDateDifference这个属性无效
 设置这个属性，必须设置billDay和repaymentDay
 */
@property(nonatomic,assign)BOOL isForceSelectionBetweenBillDateAndRepaymentDate;


/**
 设置完上面的数据，刷新UI
 */
-(void)setCompleteDataRefreshUI;


@end


@interface CRCalendarCollectionCell : UICollectionViewCell

//日历模型
@property(nonatomic,strong)CRCalendarDateModel *dateModel;

//不传，默认蓝色
@property(nonatomic,strong)UIColor *selectColor;

@end


@interface CRCalendarDateModel : NSObject

//=============数据
@property(nonatomic,copy)NSString *showDayStr;
@property(nonatomic,copy)NSString *yyyy_MM_ddStr;
@property(nonatomic,copy)NSDate *date;

//=============状态逻辑
//是否选中
@property(nonatomic,assign)BOOL selectState;
//能不能选择
@property(nonatomic,assign)BOOL canSelect;
//是不是今天
@property(nonatomic,assign)BOOL isToday;
//是不是账单日
@property(nonatomic,assign)BOOL isBillDay;
//是不是还款日
@property(nonatomic,assign)BOOL isRepaymentDay;
@end


NS_ASSUME_NONNULL_END
