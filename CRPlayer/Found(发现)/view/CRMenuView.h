//
//  CRMenuView.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/17.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRMenuView : UIView

- (instancetype)initWithItems:(NSArray *)ItemArray
                     picArray:(NSArray *)picArray
                    width:(CGFloat)width
                     Location:(CGPoint)point
                       action:(void(^)(NSInteger index))action;

+ (void)initWithItems:(NSArray *)ItemArray
             picArray:(NSArray *)picArray
                width:(CGFloat)width
             Location:(CGPoint)point
               action:(void(^)(NSInteger index))action;



@end

NS_ASSUME_NONNULL_END
