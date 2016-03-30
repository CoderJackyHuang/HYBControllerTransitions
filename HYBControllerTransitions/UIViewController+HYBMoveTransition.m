//
//  UIViewController+HYBMoveTransition.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "UIViewController+HYBMoveTransition.h"
#import <objc/runtime.h>

static const void *s_hyb_move_transition_targetview_key = "s_hyb_move_transition_targetview_key";

@implementation UIViewController (HYBMoveTransition)

- (UIView *)hyb_toTargetView {
  return objc_getAssociatedObject(self, s_hyb_move_transition_targetview_key);
}

- (void)setHyb_toTargetView:(UIView *)hyb_toTargetView {
  objc_setAssociatedObject(self,
                           s_hyb_move_transition_targetview_key,
                           hyb_toTargetView,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
