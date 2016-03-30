//
//  UIViewController+HYBMoveTransition.h
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	@author huangyibiao
 *
 *	A category of UIViewController, for setting a target view,
 *  so that it can handle to transition to which view.
 */
@interface UIViewController (HYBMoveTransition)

/**
 * Set a target view to show. When push, it will transition to
 * the target view. and when poped, it will pop from the target view.
 */
@property (nonatomic, strong, nonnull) UIView *hyb_toTargetView;

@end
