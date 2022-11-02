//
//  MyTextField.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/11/2.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "MyTextField.h"
#import "FHScrollTextView.h"

@interface MyTextField()

@property(nonatomic, strong) FHScrollTextView *scrollTextView;

@end


@implementation MyTextField

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.scrollTextView = [[FHScrollTextView alloc] initWithFrame:self.bounds];
        self.scrollTextView.userInteractionEnabled = NO;
        [self addSubview:self.scrollTextView];
        self.scrollTextView.backgroundColor = [UIColor clearColor];
        // 设置字体大小，默认16
        self.scrollTextView.textFont = [UIFont systemFontOfSize:16];
        // 设置字体颜色，默认blackColor
        self.scrollTextView.textColor = UIColor.lightGrayColor;
        // 设置文字左边距，默认10
        self.scrollTextView.labelLeftInset = 1;
        // 设置自动滚动间隔时间,默认3s
//        self.scrollTextView.autoScrollTimeInterval = 2;
        // 设置文字方向，默认左对齐
        self.scrollTextView.textAlignment = NSTextAlignmentLeft;
//        scrollTextView.textArr = @[@"0000000000",@"1111111111",@"2222222222",@"3333333333",@"4444444444"];
        
//        self.scrollTextView = scrollTextView;
        
    }
    return self;
}


- (void)setHiddenCoverView:(BOOL)hiddenCoverView{
    _hiddenCoverView = hiddenCoverView;
    self.scrollTextView.hidden = hiddenCoverView;
}

- (NSString *)getScrollNowText{
    if(self.scrollTextView.getNowCellText && self.scrollTextView.getNowCellText.length >0){
        return self.scrollTextView.getNowCellText;
    }
    
    return @"";
}

//- (void)hiddenCoverView:(BOOL)hidden{
//    self.scrollTextView.hidden = hidden;
//}

- (void)setScrollData:(NSArray *)dataArray{
    if(!dataArray){
        return;
    }
    if(dataArray.count ==0){
        return;
    }
    self.scrollTextView.textArr = dataArray;
}



//- (CGRect)placeholderRectForBounds:(CGRect)bounds{
//    return [super placeholderRectForBounds:bounds];
//}


//通过重写uitextfield的drawplaceholderinrect:方法修改占位文字颜色
//- (void)drawPlaceholderInRect:(CGRect)rect{
//    // 计算占位文字的 size
//     CGSize placeholdersize = [self.placeholder sizeWithAttributes:
//            @{NSFontAttributeName : self.font}];
//    [self.placeholder drawInRect:CGRectMake(0, (rect.size.height - placeholdersize.height)/2, rect.size.width, rect.size.height) withAttributes:@{NSForegroundColorAttributeName: UIColor.blueColor, NSFontAttributeName: self.font}];
//
//}


@end
