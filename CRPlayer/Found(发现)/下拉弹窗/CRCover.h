//
//  CRCover.h
//  CRPlayer
//
//  Created by appleDeveloper on 2022/3/3.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRCover : UIView
/**
 *  点击蒙版调用
 */
@property (nonatomic, strong) void(^clickCover)(void);
@end

NS_ASSUME_NONNULL_END
