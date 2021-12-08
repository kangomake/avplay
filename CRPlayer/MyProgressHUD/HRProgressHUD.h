//
//  HRProgressHUD.h
//  CRPlayer
//
//  Created by appleDeveloper on 2021/10/26.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HRProgressHUD : UIView

+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
