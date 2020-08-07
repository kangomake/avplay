//
//  CRVideoComplexControlBar.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/7.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRPlayerProgress.h"

NS_ASSUME_NONNULL_BEGIN


#define ControlBarHeight (40 + ProgressHeight)


@interface CRVideoComplexControlBar : UIView

@property (nonatomic, strong) CRPlayerProgress *progress;

@end

NS_ASSUME_NONNULL_END
