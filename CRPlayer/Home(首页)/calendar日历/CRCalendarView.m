//
//  CRCalendarView.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/8/16.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRCalendarView.h"
#import "CRScreen.h"

#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseFestival @[@"除夕",@"春节",@"中秋",@"五一",@"国庆节",@"儿童节",@"圣诞",@"七夕",@"端午节",@"清明节",@"元宵节",@"重阳节",@"腊八节",@"小年",@"建军节",@"妇女节",@"植树节",@"青年节",@"愚人节",@"元旦"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]

@interface CRCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *showDateLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
//这个月有几天 数组 （内部有空数据，是星期占位用的）
@property(nonatomic,strong)NSMutableArray *numberOfDaysInMonthArrM;
//当前日期的时间
@property(nonatomic,strong)NSDate *currentDate;
//今天日期
@property(nonatomic,assign)NSInteger currentrDayNumber;

@end

@implementation CRCalendarView


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        //==============配置一些初始数据
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
        //是否可以选择今天，默认是可以
        self.isCanSelectToday=YES;
        //可以选择的最大日期差。从今天开始算起，今天第0天,默认25天间隔
        self.maxSelectDateDifference=25;
        //当前时间
        self.currentDate=[NSDate date];
        //可以选择最多的天数，默认最多选择25天
        self.canSelectMostDate=25;
        
        
        [self configureCalendarViewUI];
        
        //============配置日历时间
        [self confireuiDataWithDate:self.currentDate];
    }
    return self;
}

- (void)configureCalendarViewUI{
    
    CGFloat itemWith = kScreenWidth/7;
    
    
    //===============
    UIView *bgWhiteView=[[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-((50+50+40)*KWScale+itemWith*6), kScreenWidth, ((50+50+40)*KWScale+itemWith*6))];
    [self addSubview:bgWhiteView];
    bgWhiteView.backgroundColor=[UIColor whiteColor];
    
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(10*KWScale, 10*KWScale, 40*KWScale, 30*KWScale)];
    [bgWhiteView addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font= [UIFont systemFontOfSize:14.0];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [cancelBtn addTarget:self action:@selector(Action_cancelBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *determineBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-50*KWScale, 10*KWScale, 40*KWScale, 30*KWScale)];
    [bgWhiteView addSubview:determineBtn];
    [determineBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    determineBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [determineBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [determineBtn addTarget:self action:@selector(Action_determineBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //===============
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 50*KWScale-1, kScreenWidth, 1)];
    [bgWhiteView addSubview:lineView];
    lineView.backgroundColor=RGB(245, 245, 245);
    
    
    //===============
    self.showDateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 60*KWScale, kScreenWidth, 30*KWScale)];
    [bgWhiteView addSubview:self.showDateLabel];
    self.showDateLabel.font=[UIFont systemFontOfSize:14.0];
    self.showDateLabel.textAlignment=NSTextAlignmentCenter;
    
    
    UIButton *leftMonthBtn=[[UIButton alloc]initWithFrame:CGRectMake(120*KWScale, 60*KWScale, 30*KWScale, 30*KWScale)];
    [bgWhiteView addSubview:leftMonthBtn];
    [leftMonthBtn setTitle:@"◀" forState:(UIControlStateNormal)];
    leftMonthBtn.titleLabel.font=[UIFont systemFontOfSize:20.0];
    [leftMonthBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [leftMonthBtn addTarget:self action:@selector(Action_leftMonthBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *rightMonthBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-(120+30)*KWScale, 60*KWScale, 30*KWScale, 30*KWScale)];
    [bgWhiteView addSubview:rightMonthBtn];
    [rightMonthBtn setTitle:@"▶" forState:(UIControlStateNormal)];
    rightMonthBtn.titleLabel.font=[UIFont systemFontOfSize:20.0];
    [rightMonthBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [rightMonthBtn addTarget:self action:@selector(Action_rightMonthBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    //========================
    NSArray *weekStrArr=@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i<7; i++) {
        
        UILabel *weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(itemWith*i, 100*KWScale, itemWith, 40*KWScale)];
        [bgWhiteView addSubview:weekLabel];
        weekLabel.textAlignment=NSTextAlignmentCenter;
        weekLabel.font=[UIFont systemFontOfSize:14.0];
        weekLabel.text=weekStrArr[i];
    }
    
    
    //创建一个layout布局类
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing=0;
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.itemSize = CGSizeMake(itemWith, itemWith);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 140*KWScale, kScreenWidth, itemWith*6) collectionViewLayout:flowLayout];
    [bgWhiteView addSubview:self.collectionView];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.scrollEnabled=NO;
    self.collectionView.showsVerticalScrollIndicator=NO;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
 
    [self.collectionView registerClass:[CRCalendarCollectionCell class] forCellWithReuseIdentifier:@"CRCalendarCollectionCell"];
    
}

- (UIViewController *)findViewController{
    
    UIResponder *responder = [self nextResponder];
    do{
        if([responder isKindOfClass:[UIViewController class]]){
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }while(responder !=nil);
    return nil;
    
}

#pragma mark - 按钮事件
-(void)Action_cancelBtn{
    
    self.hidden=YES;
}

-(void)Action_determineBtn{
    
    if (self.selectDatesArrayM.count==0) {
        
        UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"请选择日期" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertC addAction:action1];
        [[self findViewController] presentViewController:alertC animated:YES completion:nil];
        return;
    }
    
    self.hidden=YES;
//    self.selectDatesArrayM = [[self.selectDatesArrayM sortedArrayUsingComparator:^NSComparisonResult(HXJCalendarDateModel *obj1,HXJCalendarDateModel *obj2) {
//
//        //对数组进行排序（升序）
//        return [obj1.yyyy_MM_ddStr compare:obj2.yyyy_MM_ddStr];
//        //对数组进行排序（降序）
////        return [obj1.yyyy_MM_ddStr compare:obj2.yyyy_MM_ddStr];
//    }] mutableCopy];
    
    if (self.selectBlock) {
        self.selectBlock(self.selectDatesArrayM);
    }
    
//    当回调后，是否清除已选中的日期，默认NO
    if (self.whenSelectBlockToClearSelectDatesArrM) {

        for (CRCalendarDateModel *selectDateModel in self.selectDatesArrayM) {

            selectDateModel.selectState=NO;
        }

        [self.selectDatesArrayM removeAllObjects];

        [self.collectionView reloadData];
    }
}

-(void)Action_leftMonthBtn{
    
    self.currentDate = [self addAndSubtractMonth:-1 WithDate:self.currentDate];
    [self confireuiDataWithDate:self.currentDate];
}

-(void)Action_rightMonthBtn{
    
    self.currentDate = [self addAndSubtractMonth:1 WithDate:self.currentDate];
    [self confireuiDataWithDate:self.currentDate];
}

-(NSDate *)addAndSubtractMonth:(NSInteger)number WithDate:(NSDate *)currentDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
//    [lastMonthComps setYear:1];
    [lastMonthComps setMonth:number];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
//    NSLog(@"newdate-%@",newdate);
    return newdate;
}

#pragma mark --UICollection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numberOfDaysInMonthArrM.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CRCalendarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CRCalendarCollectionCell" forIndexPath:indexPath];
//    cell.selectColor=self.selectColor;
    cell.dateModel=self.numberOfDaysInMonthArrM[indexPath.row];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CRCalendarDateModel *dateModel=self.numberOfDaysInMonthArrM[indexPath.row];
    
    if (!dateModel.canSelect) {
        //空格占位日期不让选择
        return;
    }
    
    
    dateModel.selectState=!dateModel.selectState;
    
    if (dateModel.selectState) {
        
        if (self.selectDatesArrayM.count >=self.canSelectMostDate) {
            
            dateModel.selectState=NO;
            
//            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"最多选择%@个",@(self.canSelectMostDate)]];
            return;
        }
        
        [self whenNoContainsObjectDateModelAdd:dateModel andContainsIsRemove:NO];
        
    }else{
        
        [self whenNoContainsObjectDateModelAdd:dateModel andContainsIsRemove:YES];
    }
    
    
    //当选择达到个数，直接消失自己，默认NO
    if (self.whenChoiceReachesNumberDisappearSelf) {
        
        if (self.selectDatesArrayM.count >= self.canSelectMostDate) {
            
            [self Action_determineBtn];
        }
    }
    
    
    //这个放最后，刷新界面
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

//当选中日期的数组里，没有这个日期，就保存它，有的话，给移除状态就移除
-(void)whenNoContainsObjectDateModelAdd:(CRCalendarDateModel *)dateModel andContainsIsRemove:(BOOL)isRemove{
    
    BOOL isContainsObject=NO;
    
    for (CRCalendarDateModel *addDateModel in self.selectDatesArrayM) {
        
        if ([addDateModel.yyyy_MM_ddStr isEqualToString:dateModel.yyyy_MM_ddStr]) {
            
            isContainsObject=YES;
            
            //要移除
            if (isRemove) {
                
                [self.selectDatesArrayM removeObject:addDateModel];
            }
            
            break;
        }
        
    }
    
    //没有包含 并且不是移除，就添加
    if ((!isContainsObject) && (!isRemove)) {
        
        [self.selectDatesArrayM addObject:dateModel];
    }
}



#pragma mark - 数据配置
-(void)confireuiDataWithDate:(NSDate *)date{
    
    //==================
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    //当前的年份
    NSInteger currentYear = [components year];
    //当前的月份
    NSInteger currentMonth = [components month];
    //当前的日
    NSInteger currentrDay = [components day];
    //今天日期
    self.currentrDayNumber=currentrDay;
    
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *firstDay =[dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(currentYear),@(currentMonth),@(1)]];
    unsigned unitFlags2 = NSCalendarUnitWeekday;
    NSDateComponents* components2 = [calendar components:unitFlags2 fromDate:firstDay];
    //当前的星期，周日是1，周一是2。。。。周六是7
    NSInteger startDayIndex = [components2 weekday];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    //当前这个月有多少天
    NSUInteger numberOfDaysInMonth = range.length;
    
    self.numberOfDaysInMonthArrM=[[NSMutableArray alloc]init];
    
    
    //周日第一个，第一天是周几，补充空白占位
    for (NSInteger i=1; i<startDayIndex; i++) {
        
        CRCalendarDateModel *dateModel=[[CRCalendarDateModel alloc]init];
        dateModel.showDayStr=@"";
        dateModel.yyyy_MM_ddStr=@"";
        
        [self.numberOfDaysInMonthArrM addObject:dateModel];
    }
    
    
    for (NSInteger i=1; i <= numberOfDaysInMonth; i++) {
        
        CRCalendarDateModel *dateModel=[[CRCalendarDateModel alloc]init];
        dateModel.showDayStr=[NSString stringWithFormat:@"%@",@(i)];
        dateModel.yyyy_MM_ddStr=[NSString stringWithFormat:@"%04ld-%02ld-%02ld",(long)@(currentYear).integerValue,(long)@(currentMonth).integerValue,(long)@(i).integerValue];
        
        //add
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        dateModel.date = [dateFormatter dateFromString:dateModel.yyyy_MM_ddStr];
        
        
        
        if (self.billDay.length) {
            if (i==self.billDay.integerValue) {
                dateModel.isBillDay=YES;
            }
        }
        
        if (self.repaymentDay.length) {
            if (i==self.repaymentDay.integerValue) {
                dateModel.isRepaymentDay=YES;
            }
        }
        
        [self compareToDayWithDateModel:dateModel];
        
        [self whenSelectDatesArrMContainsDateModelChangeModelSelectState:dateModel];
        
        [self.numberOfDaysInMonthArrM addObject:dateModel];
    }
    
    //==================刷新数据
    [self.collectionView reloadData];
    self.showDateLabel.text=[NSString stringWithFormat:@"%@年 %@月",@(currentYear),@(currentMonth)];
}

//比较两个日期大小
-(void)compareToDayWithDateModel:(CRCalendarDateModel *)dateModel{
    
    //获取系统时间戳
    NSDate* toDay = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *toDayStr = [formatter stringFromDate:toDay];
    NSDate *toDayDate=[formatter dateFromString:toDayStr];
    NSDate *selectDayDate=[formatter dateFromString:dateModel.yyyy_MM_ddStr];
    
    
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitDay;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:toDayDate toDate:selectDayDate options:0];
    NSInteger dayDifference = dateCom.day;
    
    
    //==========强制只能在账单日和还款日之间选
    if (self.isForceSelectionBetweenBillDateAndRepaymentDate) {
        
        [self configureSelectionBetweenBillDateAndRepaymentDateWithDayDifference:dayDifference dateModel:dateModel];
        
    }else{
        
        //===========限制选择最大日期maxSelectDateDifference
        [self configureLimitMaxSelectDateDifferenceWithDayDifference:dayDifference dateModel:dateModel];
    }
    
    //不能选择未来时间
    if (self.canNotSelectFutureDate) {
        
        if (dayDifference>0) {
            
            dateModel.canSelect=NO;
        }else{
            dateModel.canSelect=YES;
        }
    }
    
    
    //===========能否选择全部日期
    if (self.isCanSelectAllDays) {
        
        dateModel.canSelect=YES;
    }
    
}
//==========只能在账单日和还款日之间选
-(void)configureSelectionBetweenBillDateAndRepaymentDateWithDayDifference:(NSInteger)dayDifference dateModel:(CRCalendarDateModel *)dateModel{
    
    /*
    制定计划需要在账单日和还款日之间可选，超过日期的不可选或隐藏
    
    一、账单日和还款日在同一个月内（如账单5号，还款日22号）
    1.当天日期在账单日之前，或还款日之后。
    如当天是2号，可选日期为5-22号，不可选的日期隐藏。 如当天是26号，显示可选日期为下个月的 5-22 号。
    2.当天日期在账单日和还款日之间的
    如果当天是 22号，今天可选就显示22号，今天不可选，就什么都没的选。
     
    二、账单日和还款日不在同一个月（如账单22号，还款日7号）
    1.当天日期在账单日之前，或还款日之后。
    如当天是16号，可选日期为 本月的22至下月7号
    2.如当天日期在账单日和还款日之间的
    如当天日期是1号，可选日期为 2号至7号
    
    */
    
    //1.0账单日小于还款日，两个 在 同一个月
    if (self.billDay.integerValue <= self.repaymentDay.integerValue) {
        
        //1.0账单日小于还款日，两个 在 同一个月 先弄出大筛选规定，每个月都能选择的
        if (dateModel.showDayStr.integerValue>=self.billDay.integerValue && dateModel.showDayStr.integerValue <=self.repaymentDay.integerValue&&dayDifference>=0) {
            
             //1.1 当天日期 > 还款日，可选日期 在 下个月
            if (self.currentrDayNumber>self.repaymentDay.integerValue) {
                
                //可选日期 在 下个月
                if ((self.currentrDayNumber+dayDifference) <= (self.repaymentDay.integerValue+31)) {
                    
                    dateModel.canSelect=YES;
                }else{
                    
                    dateModel.canSelect=NO;
                }
                
            }else{
                
                //1.2 当天 <= 还款日日期，可选日期在当月
                //日期 >= 当天, 并且 日期 >= 账单日 ,日期 <= 还款日 可选 ，则可选日期是在账单日和还款日之间
                if ((self.currentrDayNumber+dayDifference)<=31) {
                    
                    dateModel.canSelect=YES;
                }else{
                    
                    dateModel.canSelect=NO;
                }
            }
        }else{
            
            dateModel.canSelect=NO;
        }
        
        
    }else{
        //2.0 账单日大于还款日，两个 不在 同一个月,先弄出大筛选规定，每个月都能选择的
        if ((dateModel.showDayStr.integerValue >=self.billDay.integerValue || dateModel.showDayStr.integerValue <=self.repaymentDay.integerValue)&&dayDifference>=0) {
            
            //2.1 当天日期在还款日之后。（如账单22号，还款日7号,如当天是16号，可选日期为 本月的22至下月7号,或者当天是25号，则本月25号到下月7号）
            if (self.currentrDayNumber>self.repaymentDay.integerValue) {
                
                if ((self.currentrDayNumber+dayDifference)>=self.billDay.integerValue&&(self.currentrDayNumber+dayDifference)<=(31+self.repaymentDay.integerValue)) {
                    
                    dateModel.canSelect=YES;
                }else{

                    dateModel.canSelect=NO;
                }
                
            }else{
                //2.2当天日期在还款日之前,(如账单22号，还款日7号,如当天日期是1号，可选日期为 2号至7号）
                if ((dayDifference+self.currentrDayNumber)<=self.repaymentDay.integerValue) {
                    
                    dateModel.canSelect=YES;
                }else{
                    
                    dateModel.canSelect=NO;
                }
                
            }
        }else{
            
            dateModel.canSelect=NO;
        }
        
    }
    
    //今天能否选择
    if (dayDifference == 0) {
        //今天
        dateModel.canSelect=dateModel.canSelect?self.isCanSelectToday:NO;
        dateModel.isToday=YES;
    }
    
    /*
     账单日当天不能选择
     如果账单日当天想选择，下面的代码注释掉就行了
     千万不能改成YES，不然每个月的账单日都可以选择了
     */
    if (self.billDay.integerValue == dateModel.showDayStr.integerValue) {
        dateModel.canSelect=NO;
    }
    
    
}


//===========限制选择最大日期maxSelectDateDifference
-(void)configureLimitMaxSelectDateDifferenceWithDayDifference:(NSInteger)dayDifference dateModel:(CRCalendarDateModel *)dateModel{
    
    //==========显示今天
    if (dayDifference == 0) {
        //今天
        dateModel.canSelect=self.isCanSelectToday;
        dateModel.isToday=YES;
    }else if (dayDifference > 0) {
        
        //是否限制最大选择日期
        if (self.maxSelectDateDifference == 0) {
            
            dateModel.canSelect=YES;
        }else{
            
            if (dayDifference <= self.maxSelectDateDifference) {
                //最大可以选择日期
                dateModel.canSelect=YES;
            }else{
                
                dateModel.canSelect=NO;
            }
        }
        
    }else{
        //其余时间不可选
        dateModel.canSelect=NO;
    }
}


/*
 当选中的日期里包含了当前日期模型，改变它的选中状态，
 因为每个月都是新的日期模型，所以要比对日期，
 在这里判断，只需要循环一次，在返回的cell判断，每次刷新都要循环，内存浪费严重
 */
-(void)whenSelectDatesArrMContainsDateModelChangeModelSelectState:(CRCalendarDateModel *)dateModel{
    
    for (CRCalendarDateModel *addDateModel in self.selectDatesArrayM) {
        
        if ([addDateModel.yyyy_MM_ddStr isEqualToString:dateModel.yyyy_MM_ddStr]) {
            
            dateModel.selectState=YES;
            
            break;
        }
    }
}

#pragma mark - 懒加载
-(NSMutableArray *)selectDatesArrayM{
    
    if (_selectDatesArrayM==nil) {
        
        _selectDatesArrayM=[[NSMutableArray alloc]init];
    }
    
    return _selectDatesArrayM;
}

#pragma mark - 赋值

-(void)setCompleteDataRefreshUI{
    
    //重新配置日历时间
    [self confireuiDataWithDate:self.currentDate];
}


@end


@interface CRCalendarCollectionCell ()
@property(nonatomic,strong)UILabel *dayNumberLabel;
@property(nonatomic,strong)UIImageView *tapSelectView;
@property(nonatomic,strong)UILabel *tipsLabel;
@end

@implementation CRCalendarCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        [self configureUI];
    }
    
    return self;
}

-(void)configureUI{
    
    self.tapSelectView=[[UIImageView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.tapSelectView];
    self.tapSelectView.layer.cornerRadius=self.contentView.bounds.size.width/2.0;
    
    
    self.dayNumberLabel=[[UILabel alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.dayNumberLabel];
    self.dayNumberLabel.font=[UIFont systemFontOfSize:14.0];
    self.dayNumberLabel.textAlignment=NSTextAlignmentCenter;
    self.dayNumberLabel.textColor=[UIColor blackColor];
    
    
    self.tipsLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.contentView.bounds.size.height-10*KWScale, self.contentView.bounds.size.width, 10*KWScale)];
    [self.contentView addSubview:self.tipsLabel];
    self.tipsLabel.font=[UIFont systemFontOfSize:12.0];
    self.tipsLabel.textAlignment=NSTextAlignmentCenter;
    self.tipsLabel.textColor=[UIColor blueColor];
    
}

- (void)setDateModel:(CRCalendarDateModel *)dateModel{
    
    _dateModel = dateModel;
    //日期赋值显示
    self.dayNumberLabel.text=dateModel.showDayStr;
    
    
    //显示账单日，还款日
    self.tipsLabel.text=@"";
    if (dateModel.isBillDay) {
        self.tipsLabel.text=@"账单日";
    }
    if(dateModel.isRepaymentDay){
        self.tipsLabel.text=@"还款日";
    }
    
    NSString * lunar = [self chineseCalendarOfDate:dateModel.date];
    self.tipsLabel.text = lunar;

    
    
    //今天特别样式
    if (dateModel.isToday) {
        self.dayNumberLabel.layer.borderWidth=1;
        self.dayNumberLabel.layer.borderColor=[UIColor redColor].CGColor;
    }else{
        self.dayNumberLabel.layer.borderWidth=0;
        self.dayNumberLabel.layer.borderColor=[UIColor clearColor].CGColor;
    }
    
    
    //显示是否能被选中
    if (dateModel.canSelect) {
        
//        if(dateModel.isToday){
//            self.dayNumberLabel.textColor = UIColor.orangeColor;
//        }else{
            self.dayNumberLabel.textColor = UIColor.blackColor;
        self.tipsLabel.textColor=[UIColor blueColor];

//        }
        
    }else{
        
        self.dayNumberLabel.textColor=[UIColor lightGrayColor];
        self.tipsLabel.textColor=[UIColor lightGrayColor];

    }
    
    
    //显示是否已经选中
    if (dateModel.selectState) {
        
        self.tapSelectView.backgroundColor=self.selectColor?self.selectColor:[[UIColor blueColor] colorWithAlphaComponent:0.5];
    }else{
        
        self.tapSelectView.backgroundColor=[UIColor clearColor];
    }
}

- (NSString *)chineseCalendarOfDate:(NSDate *)date {
    
    if(!date){
        return @"";
    }
    
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSCalendar *normalDate = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *Datecomponents = [normalDate components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSString * _day = @"";
    
    if (components.day == 1 ) {
        _day = ChineseMonths[components.month - 1];
        
    } else {
        
        _day = ChineseDays[components.day - 1];
    }
    //农历
    if (components.day == 1 && components.month == 1) {
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[1]];  //春节
    }else if (components.month == 1 && components.day == 15){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[10]]; //元宵节
    }else if(components.month == 8 && components.day == 15){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[2]];  //中秋
    }else if(components.month == 7 && components.day == 7){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[7]];  //七夕
    }else if(components.month == 5 && components.day == 5){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[8]];  //端午
    }else if(components.month == 9 && components.day == 9){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[11]]; //重阳
    }else if(components.month == 12 && components.day == 8){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[12]]; //腊八
    }else if(components.month == 12 && components.day == 23){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[13]]; //小年
    }
    //阳历
    if (Datecomponents.month == 6 && Datecomponents.day == 1) {       //儿童节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[5]];
    }else if(Datecomponents.month == 10 && Datecomponents.day == 1){  //国庆节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[4]];
    }else if(Datecomponents.month == 5 && Datecomponents.day == 1){   //劳动节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[3]];
    }else if(Datecomponents.month == 12 && Datecomponents.day == 25){ //圣诞节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[6]];
    }else if (Datecomponents.month == 4 && Datecomponents.day == 5){  //清明节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[9]];
    }else if (Datecomponents.month == 8 && Datecomponents.day == 1){  //建军节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[14]];
    }else if (Datecomponents.month == 3 && Datecomponents.day == 8){  //妇女节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[15]];
    }else if (Datecomponents.month == 3 && Datecomponents.day == 12){ //植树节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[16]];
    }else if (Datecomponents.month == 5 && Datecomponents.day == 4){  //青年节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[17]];
    }else if (Datecomponents.month == 4 && Datecomponents.day == 1){  //愚人节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[18]];
    }else if (Datecomponents.month == 1 && Datecomponents.day == 1){  //元旦
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[19]];
    }
    return _day;
}


@end


#pragma mark - 日历模型类
@implementation CRCalendarDateModel



@end
