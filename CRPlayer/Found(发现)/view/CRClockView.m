//
//  CRClockView.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/17.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRClockView.h"
#import "CRScreen.h"

@interface CRClockView ()

@property (nonatomic, strong) UIView *hourView;
@property (nonatomic, strong) UIView *minuteView;
@property (nonatomic, strong) UIView *SecondView;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIView *centerView;

@property (nonatomic, strong) UILabel *number_3;
@property (nonatomic, strong) UILabel *number_6;
@property (nonatomic, strong) UILabel *number_9;
@property (nonatomic, strong) UILabel *number_12;




@end


@implementation CRClockView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.number_3];
        [self.bgView addSubview:self.number_6];
        [self.bgView addSubview:self.number_9];
        [self.bgView addSubview:self.number_12];
        [self.bgView addSubview:self.centerView];

        [self.bgView addSubview:self.SecondView];
        [self.bgView addSubview:self.minuteView];
        [self.bgView addSubview:self.hourView];
        
        
        
        self.SecondView.center = self.bgView.center;
        self.minuteView.center = self.bgView.center;
        self.hourView.center = self.bgView.center;
        self.SecondView.layer.anchorPoint = CGPointMake(0.5, 0.9);
        self.minuteView.layer.anchorPoint = CGPointMake(0.5, 0.9);
        self.hourView.layer.anchorPoint = CGPointMake(0.5, 0.9);
        
        [self tick];

        if (@available(iOS 10.0, *)) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
                [self tick];
            }];
        } else {
            // Fallback on earlier versions
        }
        
        //拖动手势
        [self addGestureRecognizer:({
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(viewPan:)];
            pan;
            
        })];
        
    }
    return self;
}


- (void)tick{
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *componets = [calendar components:units fromDate:[NSDate now]];
    CGFloat hoursAngle = (componets.hour /12.0) * M_PI * 2.0;
    CGFloat minsAngle = (componets.minute / 60.0) * M_PI * 2.0;
    CGFloat SecsAngle = (componets.second /60.0) * M_PI * 2.0;
    
    self.SecondView.transform = CGAffineTransformMakeRotation(SecsAngle);
    self.minuteView.transform = CGAffineTransformMakeRotation(minsAngle);
    self.hourView.transform = CGAffineTransformMakeRotation(hoursAngle);

//    NSLog(@"sec-%ld,min-%ld,hour-%ld",(long)componets.second,(long)componets.minute,(long)componets.hour);
    
}

#pragma mark --UIPanGestureRecognizer
- (void)viewPan:(UIPanGestureRecognizer *)pan{
    
    if(self.panViewBlock){
        self.panViewBlock(pan);
    }
}



#pragma mark -- Lazy load

- (UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        _bgView.backgroundColor = RGBA(240, 240, 240, 0.8);
        _bgView.layer.cornerRadius = self.frame.size.width/2;
//        _bgView.layer.borderWidth = 1;
//        _bgView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _bgView;
}

- (UIView *)hourView{
    if(!_hourView){
        _hourView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 6, self.frame.size.width/2-16)];
        _hourView.backgroundColor = [UIColor blackColor];
        _hourView.layer.cornerRadius = 3;
    }
    return _hourView;
}

- (UIView *)minuteView{
    if(!_minuteView){
        _minuteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, self.frame.size.width/2-9)];
        _minuteView.backgroundColor = [UIColor blackColor];
        _minuteView.layer.cornerRadius = 2;
    }
    return _minuteView;
}

- (UIView *)SecondView{
    if(!_SecondView){
        _SecondView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2, self.frame.size.width/2-6)];
        _SecondView.backgroundColor = [UIColor redColor];
    }
    return _SecondView;
}

- (UIView *)centerView{
    
    if(!_centerView){
        _centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
        _centerView.center = self.bgView.center;
        _centerView.layer.cornerRadius = 4;
        _centerView.backgroundColor = [UIColor blackColor];
    }
    return _centerView;
}


- (UILabel *)number_3{
    
    if(!_number_3){
        _number_3 = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - 10, (self.frame.size.height - 10)/2, 10, 10)];
        _number_3.text = @"3";
        _number_3.textColor = [UIColor blackColor];
        _number_3.textAlignment = NSTextAlignmentCenter;
        _number_3.font = [UIFont boldSystemFontOfSize:9];
    }
    return _number_3;
}
- (UILabel *)number_6{
    
    if(!_number_6){
        _number_6 = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 10)/2, self.frame.size.height -10, 10, 10)];
        _number_6.text = @"6";
        _number_6.textColor = [UIColor blackColor];
        _number_6.textAlignment = NSTextAlignmentCenter;
        _number_6.font = [UIFont boldSystemFontOfSize:9];
    }
    return _number_6;
}

- (UILabel *)number_9{
    
    if(!_number_9){
        _number_9 = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.frame.size.height - 10)/2, 10, 10)];
        _number_9.text = @"9";
        _number_9.textColor = [UIColor blackColor];
        _number_9.textAlignment = NSTextAlignmentCenter;
        _number_9.font = [UIFont boldSystemFontOfSize:9];
    }
    return _number_9;
}

- (UILabel *)number_12{
    
    if(!_number_12){
        _number_12 = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 20)/2, 2, 20, 10)];
        _number_12.text = @"12";
        _number_12.textColor = [UIColor blackColor];
        _number_12.textAlignment = NSTextAlignmentCenter;
        _number_12.font = [UIFont boldSystemFontOfSize:9];
    }
    return _number_12;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
