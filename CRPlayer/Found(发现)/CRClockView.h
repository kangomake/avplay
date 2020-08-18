//
//  CRClockView.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/17.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//模拟钟表
@interface CRClockView : UIView

- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, copy) void (^panViewBlock)(UIPanGestureRecognizer *pan);

@end

NS_ASSUME_NONNULL_END
