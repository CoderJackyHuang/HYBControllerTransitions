//
//  HYBEaseInOutTransition.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/4/6.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBEaseInOutTransition.h"

@implementation HYBEaseInOutTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIView *containerView = [transitionContext containerView];
  
  if (containerView == nil) {
    return;
  }
  
  UIView *fromView = [self fromView:transitionContext];
  UIView *toView = [self toView:transitionContext];
  
  [containerView addSubview:toView];
  
  toView.alpha = 0.0;
  fromView.alpha = 1.0;
  
  if (self.animatedWithSpring == NO) {
    [UIView animateWithDuration:self.duration animations:^{
      fromView.alpha = 0.0;
      toView.alpha = 1.0;
    } completion:^(BOOL finished) {
      
      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
  } else {
    [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:self.damp initialSpringVelocity:self.initialSpringVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
      fromView.alpha = 0.0;
      toView.alpha = 1.0;
    } completion:^(BOOL finished) {
      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
  }
}

@end
