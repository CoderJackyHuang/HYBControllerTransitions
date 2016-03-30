//
//  HYBModalTransition.h
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBBaseTransition.h"

/**
 *	@author huangyibiao
 *
 *	Modal transition animation, it will show usually half for the 
 *  destination view controller's view, and scale the from view.
 *
 *  @Note It only supports present and dismiss mode.
 */
@interface HYBModalTransition : HYBBaseTransition

/**
 *	Make the from view scale to the specified scale.
 *
 *  Default is (0.9, 0.9)
 */
@property (nonatomic, assign) CGPoint scale;

/**
 *	@author huangyibiao
 *
 *	The height for destination view to present.
 *  
 *  Default is half of destination view, it means desView.frame.size.height / 2
 */
@property (nonatomic, assign) CGFloat presentedHeight;

/**
 *  Whether to include navigation bar when take scapshots.
 *	Default is YES. If NO, it has only the presenting view.
 */
@property (nonatomic, assign) BOOL scapshotIncludingNavigationBar;

/**
 *	@author huangyibiao
 *
 *	When tap on the presenting view, should it automatically is dismissed.
 *
 *  Default is YES.
 */
@property (nonatomic, assign) BOOL shouldDismissOnTap;


@end
