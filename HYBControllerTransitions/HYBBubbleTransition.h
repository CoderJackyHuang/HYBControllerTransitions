//
//  HYBBubbleTransitionAnimation.h
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/29.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBBaseTransition.h"


/**
 * GITHUB           : https://github.com/CoderJackyHuang/HYBControllerTransitions
 * Chinese Document : http://www.henishuo.com/transition-chinese-document/
 * Author Blog      : http://www.henishuo.com/
 * Email            : huangyibiao520@163.com
 *
 * Please give me a feed back when there is something wrong, or you need a special effec.
 *
 *	A custom modal transition that presents and dismiss a controller
 *  with an expanding bubble effect.
 *
 *  @Note The bubble transition only supports present and dismiis mode.
 */
@interface HYBBubbleTransition : HYBBaseTransition

/**
 * The color of the bubble. It should be the destination controller's
 * background color, so that it could look much better.
 */
@property (nonatomic, strong) UIColor *bubbleColor;

/**
 * The start point for the beginning of a bubble and it will shrink
 * to this point when dismiss.
 *
 * Default value is {toView.size.width / 2, toView.size.height}
 *
 * Though here supports default value, you should set a starting point
 * so that it can bubble from your settring point.
 */
@property (nonatomic, assign) CGPoint bubbleStartPoint;

@end
