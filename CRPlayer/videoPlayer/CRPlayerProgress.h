//
//  CRPlayerProgress.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/7.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


#define ProgressHeight 25

NS_ASSUME_NONNULL_BEGIN

@interface CRPlayerProgress : UIView
{
//    UISlider *slider;
}

@property (nonatomic, assign) float playSecond;
@property (nonatomic, assign) float bufferProgress;
@property (nonatomic, strong) UISlider *slider;

- (void)setMaxTime:(CMTime)duration;

@property (nonatomic, copy) void(^seekToSecondBlock)(float second);


@end

NS_ASSUME_NONNULL_END
