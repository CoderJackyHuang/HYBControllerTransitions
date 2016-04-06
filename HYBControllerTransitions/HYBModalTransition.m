//
//  HYBModalTransition.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBModalTransition.h"

@interface HYBModalTransition ()

@property (nonatomic, weak) UIViewController *fromViewController;

@end

@implementation HYBModalTransition

- (instancetype)initWithPresented:(HYBTransitionPresented)presentedCallback
                        dismissed:(HYBTransitionDismiss)dismissCallback {
  if (self = [super initWithPresented:presentedCallback dismissed:dismissCallback]) {
    self.presentedHeight = NSNotFound;
    self.shouldDismissOnTap = YES;
    self.scale = CGPointMake(0.9, 0.9);
    self.scapshotIncludingNavigationBar = YES;
  }
  
  return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIView *containerView = [transitionContext containerView];
  
  if (containerView == nil) {
    return;
  }
  
  if (self.transitionMode == kHYBTransitionPresent) {
    UIView *fromView = [self fromView:transitionContext];
    UIView *toView = [self toView:transitionContext];
    
    CGFloat height = self.presentedHeight;
    if ([self shouldUseDefaultHeight]) {
      height = toView.frame.size.height / 2;
    }
    
    self.presentedHeight = height;
    
    UIView *fromTempView = nil;
    if (self.scapshotIncludingNavigationBar) {
      fromTempView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
    } else {
      fromTempView = [fromView snapshotViewAfterScreenUpdates:NO];
    }
    
    fromTempView.frame = fromView.frame;
    [containerView addSubview:fromTempView];
    
    if (self.shouldDismissOnTap) {
      self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(onTapToDismiss)];
      fromTempView.userInteractionEnabled = YES;
      [fromTempView addGestureRecognizer:tap];
    }
    
    fromView.alpha = 0.0;
    
    toView.frame = CGRectMake(toView.frame.origin.x,
                              containerView.frame.size.height,
                              toView.frame.size.width,
                              height);
    [containerView addSubview:toView];
    
    if (self.animatedWithSpring == NO) {
      [UIView animateWithDuration:self.duration animations:^{
        toView.transform = CGAffineTransformMakeTranslation(0, -height);
        fromTempView.transform = CGAffineTransformMakeScale(self.scale.x, self.scale.y);
      } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    } else {
      [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:self.damp initialSpringVelocity:self.initialSpringVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toView.transform = CGAffineTransformMakeTranslation(0, -height);
        fromTempView.transform = CGAffineTransformMakeScale(self.scale.x, self.scale.y);
      } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    }
  } else if (self.transitionMode == kHYBTransitionDismiss) {
    UIView *toView = [self toView:transitionContext];
    
    UIView *fromTempView = [containerView.subviews firstObject];
    UIView *currentPresentingView = [containerView.subviews lastObject];
    
    if (![self animatedWithSpring]) {
      [UIView animateWithDuration:self.duration animations:^{
        fromTempView.transform = CGAffineTransformIdentity;
        currentPresentingView.transform = CGAffineTransformIdentity;
      } completion:^(BOOL finished) {
        toView.alpha = 1.0;
        [fromTempView removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    } else {
      [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:self.damp initialSpringVelocity:self.initialSpringVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromTempView.transform = CGAffineTransformIdentity;
        currentPresentingView.transform = CGAffineTransformIdentity;
      } completion:^(BOOL finished) {
        toView.alpha = 1.0;
        [fromTempView removeFromSuperview];

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    }
  } else {
    NSLog(@"Only support kHYBTransitionDismiss and kHYBTransitionPresent mode.");
  }
}


- (BOOL)shouldUseDefaultHeight {
  return self.presentedHeight == NSNotFound;
}

- (void)onTapToDismiss {
  [self.fromViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
