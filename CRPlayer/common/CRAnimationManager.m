//
//  CRAnimationManager.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/23.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRAnimationManager.h"


@interface CRAnimationManager ()

@end


@implementation CRAnimationManager

- (instancetype)initWithType:(kAnimationType)type{
    if(self = [super init]){
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
   
    UIViewController *formVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *formV = formVC.view;
    UIView *toV = toVC.view;
    
    UIView *containView = [transitionContext containerView];
    containView.backgroundColor = [UIColor whiteColor];
    
    toV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, containView.frame.size.width, containView.frame.size.height);
    [containView addSubview:toV];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        formV.transform = CGAffineTransformTranslate(formV.transform, -[UIScreen mainScreen].bounds.size.width, 0);
        toV.transform = CGAffineTransformTranslate(toV.transform, -[UIScreen mainScreen].bounds.size.width, 0);
        
    } completion:^(BOOL finished) {
        
        
        [transitionContext completeTransition:YES];
        
    }];
    
    
}


@end
