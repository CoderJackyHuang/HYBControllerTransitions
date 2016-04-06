//
//  HYBMoveTransition.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBMoveTransition.h"

@implementation HYBMoveTransition


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIView *containerView = [transitionContext containerView];
  
  if (containerView == nil) {
    return;
  }
  
  if (self.targetClickedView == nil) {
    NSLog(@"targetClickedView property can't be nil.");
    return;
  }
  
  if (self.transitionMode == kHYBTransitionPush) {
    UIView *toView = [self toView:transitionContext];
    UIView *tempView = [self.targetClickedView snapshotViewAfterScreenUpdates:NO];
    
    tempView.frame = [self.targetClickedView convertRect:self.targetClickedView.bounds
                                                  toView:containerView];
    
    [containerView addSubview:toView];
    [containerView addSubview:tempView];
    
    toView.alpha = 1.0;
    self.targetClickedView.alpha = 0.0;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.hyb_toTargetView.alpha = 0.0;
    CGRect targetRect = [toVC.hyb_toTargetView convertRect:toVC.hyb_toTargetView.bounds
                                                    toView:containerView];
    if (self.animatedWithSpring) {
      [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:self.damp initialSpringVelocity:self.initialSpringVelocity options:0 animations:^{
        tempView.frame = targetRect;
      } completion:^(BOOL finished) {
        toView.alpha = 1.0;
        tempView.alpha = 0.0;
       toVC.hyb_toTargetView.alpha = 1.0;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    } else {
      [UIView animateWithDuration:self.duration animations:^{
        tempView.frame = targetRect;
      } completion:^(BOOL finished) {
        toView.alpha = 1.0;
        tempView.alpha = 0.0;
        toVC.hyb_toTargetView.alpha = 1.0;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    }
  } else if (self.transitionMode == kHYBTransitionPop) {
    UIView *toView = [self toView:transitionContext];
    UIView *fromView = [self fromView:transitionContext];
    UIView *tempView = [containerView.subviews lastObject];
    
    toView.alpha = 1.0;
    fromView.alpha = 1.0;
    tempView.alpha = 1.0;

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.hyb_toTargetView.alpha = 0.0;
    
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:tempView];
    
    CGRect originalRect = [self.targetClickedView convertRect:self.targetClickedView.bounds
                                                       toView:containerView];
    
    if (self.animatedWithSpring) {
      [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:self.damp initialSpringVelocity:self.initialSpringVelocity options:0 animations:^{
        tempView.frame = originalRect;
      } completion:^(BOOL finished) {
        toView.alpha = 1.0;
        tempView.alpha = 0.0;
        [tempView removeFromSuperview];
        self.targetClickedView.alpha = 1.0;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    } else {
      [UIView animateWithDuration:self.duration animations:^{
        tempView.frame = originalRect;
      } completion:^(BOOL finished) {
        toView.alpha = 1.0;
        tempView.alpha = 0.0;
        [tempView removeFromSuperview];
        self.targetClickedView.alpha = 1.0;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    }
  } else {
    NSLog(@"Only support kHYBTransitionPush and kHYBTransitionPop mode.");
  }
}

@end
