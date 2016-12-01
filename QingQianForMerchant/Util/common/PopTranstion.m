//
//  PopTranstion.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/11/3.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "PopTranstion.h"

@implementation PopTranstion
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toVC];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    toVC.view.frame = CGRectOffset(finalFrameForVC, 0, -bounds.size.height);
    [[transitionContext containerView] addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromVC.view.alpha = 0.8;
        toVC.view.frame = finalFrameForVC;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        fromVC.view.alpha = 1.0;
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8f;
}
@end
