//
//  HYBBaseTransitionAnimation.h
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/29.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * GITHUB           : https://github.com/CoderJackyHuang/HYBControllerTransitions
 * Chinese Document : http://www.henishuo.com/transition-chinese-document/
 * Author Blog      : http://www.henishuo.com/
 * Email            : huangyibiao520@163.com
 *
 * Please give me a feed back when there is something wrong, or you need a special effec.
 */


@class HYBBaseTransition;

/**
 *	@author huangyibiao
 *
 *	The block version of protocol, just see:
 *
 *  - (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
 *
 *	@param presented	The controller will be presented
 *	@param presenting	The controller to present the presented controller
 *	@param source	    The source controller
 *  @param transition The object which implement UIViewControllerTransitioningDelegate protocol.
 *                    Just strongly cast it to the subclass type which was called.
 *
 *  @Note For more information, @see UIViewControllerTransitioningDelegate
 */
typedef void(^HYBTransitionPresented)(UIViewController *presented,
                                      UIViewController *presenting,
                                      UIViewController *source,
                                      HYBBaseTransition *transition);

/**
 *	@author huangyibiao
 *
 *	The block version of protocol, just see:
 *
 *  - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
 *
 *  @param dismissed  The controller will be dismissed.
 *	@param transition The object which implement UIViewControllerTransitioningDelegate protocol.
 *                    If you want to change, you can configure it. Usually, you don't need to
 *                    config anything, and it will works well. Cast it to the real subclass type.
 *
 *  @Note For more information, @see UIViewControllerTransitioningDelegate
 */
typedef void(^HYBTransitionDismiss)(UIViewController *dismissed, HYBBaseTransition *transition);

/**
 *	@author huangyibiao
 *
 *	The call back for custom push transition animation.
 *
 *	@param fromVC			Push from view controller
 *	@param toVC				Push to view controller
 *	@param transition The object which implement UINavigationControllerDelegate for push/pop.
 *                    If you want to change, you can configure it. Usually, you don't need to
 *                    config anything, and it will works well. Cast it to the real subclass type.
 *
 *  @Note see UINavigationControllerDelegate
 */
typedef void(^HYBTransitionPush)(UIViewController *fromVC,
                                 UIViewController *toVC,
                                 HYBBaseTransition *transition);
// The same to the push
typedef HYBTransitionPush HYBTransitionPop;

/**
 * The transition mode. It's double pairs of mode.
 */
typedef NS_ENUM(NSUInteger, HYBTransitionMode) {
  kHYBTransitionDismiss, // Dismiss
  kHYBTransitionPresent, // Present
  kHYBTransitionPush,    // Push
  kHYBTransitionPop      // Pop
};

/**
 *	@author huangyibiao
 *
 *	Base class for transition animation.
 */
@interface HYBBaseTransition : NSObject <
UIViewControllerAnimatedTransitioning, // This is the required protocol.
UIViewControllerTransitioningDelegate, // for present and dismiss transition
UINavigationControllerDelegate // For push and pop transition
>

/**
 *	The duration of transition animations, for pairs of present/dissmis
 *  or push/pop. Default is 0.5s.
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 * The transition mode, Only `Dismiss`、`Present`、`Push`、`Pop`.
 * Default is `kHYBTransitionPush`
 *
 * @see For more information, just see HYBTransitionMode.
 */
@property (nonatomic, assign) HYBTransitionMode transitionMode;

/**
 * The subclass can use it directly.
 * When presented, it will be invoked if it exsists.
 */
@property (nonatomic, copy) HYBTransitionPresented animationPresentedCallback;

/**
 * The subclass can use it directly.
 * When dismissed, it will be invoked if it exsists.
 */
@property (nonatomic, copy) HYBTransitionDismiss animationDismissCallback;

/**
 * The subclass can use it directly.
 * When pushed, it will be invoked if it exsists.
 */
@property (nonatomic, copy) HYBTransitionPush animationPushedCallback;

/**
 * The subclass can use it directly.
 * When poped, it will be invoked if it exsists.
 */
@property (nonatomic, copy) HYBTransitionPop animationPopedCallback;

/**
 *	Default is NO, if set to YES, it will be presented and dismissed with
 *  spring animation.
 */
@property (nonatomic, assign) BOOL animatedWithSpring;

/**
 * The initial Spring velocity, Only when animatedWithSpring is YES, it will take effect.
 * Default is 1.0 / 0.5. If you don't know, just use the default value.
 */
@property (nonatomic, assign) CGFloat initialSpringVelocity;

/**
 *	The Spring damp, Only when animatedWithSpring is YES, it will take effect.
 *
 *  Default is 0.5. If you don't know, just use the default value.
 */
@property (nonatomic, assign) CGFloat damp;

/**
 *  The designed-initializer for present/dismiss. Subclass can override it to initialize something.
 *	Call it to create bubble transition object, with double callbacks.
 *
 *	@param presentedCallback	When presented, it will be invoked.
 *	@param dismissCallback		When dissmissed, it will be invoked.
 *
 *	@return The transition object, usually it is no use. If you really need it to
 *          Do something, you can own it strongly.
 */
- (instancetype)initWithPresented:(HYBTransitionPresented)presentedCallback
                        dismissed:(HYBTransitionDismiss)dismissCallback;

/**
 *  The designed-initializer for push/pop. Subclass can override it to initialize something.
 *	Call it to create bubble transition object, with double callbacks.

 *
 *	@param pushCallback	When pushed, it will be invoked.
 *	@param popCallback	When poped, it will be invoked.
 *
 *	@return The transition object, usually it is no use. If you really need it to
 *          Do something, you can own it strongly.
 */
- (instancetype)initWithPushed:(HYBTransitionPush)pushCallback
                         poped:(HYBTransitionPop)popCallback;

- (UIView *)toView:(id<UIViewControllerContextTransitioning>)transitionContext ;
- (UIView *)fromView:(id<UIViewControllerContextTransitioning>)transitionContext ;

@end
