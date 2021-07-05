//
//  CRAnimationManager.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/23.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, kAnimationType) {
    kAnimationTypeLeftToRight = 0,
    kAnimationTypeRightToLeft
};


NS_ASSUME_NONNULL_BEGIN

@interface CRAnimationManager : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) kAnimationType type;
- (instancetype)initWithType:(kAnimationType)type;


@end

NS_ASSUME_NONNULL_END
