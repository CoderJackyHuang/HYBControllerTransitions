//
//  HYBMoveTransition.h
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBBaseTransition.h"
#import "UIViewController+HYBMoveTransition.h"


/**
 * GITHUB           : https://github.com/CoderJackyHuang/HYBControllerTransitions
 * Chinese Document : http://www.henishuo.com/transition-chinese-document/
 * Author Blog      : http://www.henishuo.com/
 * Email            : huangyibiao520@163.com
 *
 * Please give me a feed back when there is something wrong, or you need a special effec.
 *
 *	The move transition animation, it looks like the transition animation
 *  of KeyNote move transition.
 *
 *  When click a cell or a subview, then push to a view controller and you need
 *  animation from the clicked view to the destination controller.
 *
 *  @Note It only supports push and pop mode.
 */
@interface HYBMoveTransition : HYBBaseTransition

/**
 *	The view that is clicked at the pushing view controller.
 */
@property (nonatomic, strong, nonnull) UIView *targetClickedView;

@end
