//
//  HYBBubbleTransitionAnimation.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/29.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBBubbleTransition.h"

@interface HYBBubbleTransition ()

@property (nonatomic, strong) UIView *bubbleView;

@end

@implementation HYBBubbleTransition

- (instancetype)initWithPresented:(HYBTransitionPresented)presentedCallback
                        dismissed:(HYBTransitionDismiss)dismissCallback {
  if (self = [super initWithPresented:presentedCallback dismissed:dismissCallback]) {
    self.bubbleStartPoint = (CGPoint){NSNotFound, NSNotFound};
  }
  
  return self;
}

#pragma mark - UIViewControllerContextTransitioning
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIView *containerView = [transitionContext containerView];
  
  if (containerView == nil) {
    return;
  }
  
  if (self.transitionMode == kHYBTransitionPresent) {
    UIView *toView = [self toView:transitionContext];
    CGPoint toViewDestinationCenter = toView.center;
    CGSize toViewDestionationSize = toView.frame.size;
    
    CGPoint startPoint = self.bubbleStartPoint;
    if ([self shouldUseDefaultStartingPoint]) {
      startPoint = (CGPoint){toView.frame.size.width / 2, toView.frame.size.height};
    }
    
    self.bubbleView = [[UIView alloc] init];
    self.bubbleView.backgroundColor = self.bubbleColor;
    self.bubbleView.frame = [self bubbleFrameWithDestinationSize:toViewDestionationSize];
    self.bubbleView.layer.cornerRadius = self.bubbleView.frame.size.height / 2;
    self.bubbleView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    self.bubbleView.center = startPoint;
    [containerView addSubview:self.bubbleView];
    
    toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    toView.center = startPoint;
    toView.alpha = 0.0;
    
    [containerView addSubview:toView];
    
    
    if (self.animatedWithSpring) {
      [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:self.damp initialSpringVelocity:self.initialSpringVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bubbleView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        toView.alpha = 1.0;
        toView.center = toViewDestinationCenter;
      } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    } else {
      [UIView animateWithDuration:self.duration animations:^{
        self.bubbleView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        toView.alpha = 1.0;
        toView.center = toViewDestinationCenter;
      } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    }
  } else if (self.transitionMode == kHYBTransitionDismiss) {
    UIView *fromView = [self fromView:transitionContext];
    CGSize fromViewSize = fromView.frame.size;
    CGPoint fromViewCenter = fromView.center;
    
    CGPoint startPoint = self.bubbleStartPoint;
    if ([self shouldUseDefaultStartingPoint]) {
      startPoint = (CGPoint){fromView.frame.size.width / 2, fromView.frame.size.height};
    }
    
    self.bubbleView.frame = [self bubbleFrameWithDestinationSize:fromViewSize];
    self.bubbleView.layer.cornerRadius = self.bubbleView.frame.size.height / 2;
    self.bubbleView.center = startPoint;
    
    if (self.animatedWithSpring) {
      [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:self.damp initialSpringVelocity:self.initialSpringVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bubbleView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        fromView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        fromView.alpha = 0.0;
        fromView.center = startPoint;
      } completion:^(BOOL finished) {
        fromView.center = fromViewCenter;
        [fromView removeFromSuperview];
        [self.bubbleView removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    } else {
      [UIView animateWithDuration:self.duration animations:^{
        self.bubbleView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        fromView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        fromView.alpha = 0.0;
        fromView.center = startPoint;
      } completion:^(BOOL finished) {
        fromView.center = fromViewCenter;
        [fromView removeFromSuperview];
        [self.bubbleView removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    }
  } else {
    NSLog(@"Only support kHYBTransitionDismiss and kHYBTransitionPresent mode.");
  }
}

#pragma mark - Private
- (CGRect)bubbleFrameWithDestinationSize:(CGSize)destinationSize {
  CGFloat x = fmax(self.bubbleStartPoint.x, destinationSize.width - self.bubbleStartPoint.x);
  CGFloat y = fmax(self.bubbleStartPoint.y, destinationSize.height - self.bubbleStartPoint.y);
  CGFloat radius = sqrt(x * x + y * y);
  CGFloat diameter = radius * 2;
  
  return (CGRect){0, 0, diameter, diameter};
}

- (BOOL)shouldUseDefaultStartingPoint {
  return CGPointEqualToPoint(_bubbleStartPoint, (CGPoint){NSNotFound, NSNotFound});
}



@end
