//
//  MyTextField.h
//  CRPlayer
//
//  Created by appleDeveloper on 2022/11/2.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTextField : UITextField

@property (nonatomic, assign) BOOL hiddenCoverView;

- (void)setScrollData:(NSArray *)dataArray;
- (NSString *)getScrollNowText;
@end

NS_ASSUME_NONNULL_END
