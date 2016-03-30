//
//  HYBModalBubbleTopRightViewController.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBModalBubbleTopRightViewController.h"
#import "HYBBubbleTransition.h"
#import "HYBBubbleRightViewController.h"

@interface HYBModalBubbleTopRightViewController ()

@property (nonatomic, strong) HYBBubbleTransition *bubbleTransition;

@end

@implementation HYBModalBubbleTopRightViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"bubble present from bottom";
  self.view.backgroundColor = [UIColor whiteColor];
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(self.view.frame.size.width - 80,
                            0,
                            80,
                            80);
  [button setTitle:@"+" forState:UIControlStateNormal];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  button.backgroundColor = [UIColor purpleColor];
  button.titleLabel.font = [UIFont boldSystemFontOfSize:60];
  [self.view addSubview:button];
  button.tag = 1010;
  button.layer.cornerRadius = 40;
  [button addTarget:self action:@selector(onPresent) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onPresent {
  HYBBubbleRightViewController *vc = [[HYBBubbleRightViewController alloc] init];
  vc.modalPresentationStyle = UIModalPresentationCustom;
  
  // Remember to own it strongly
  // Because delegate is weak reference, and it will be released after out of the function body.
  self.bubbleTransition = [[HYBBubbleTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
    // You need to cast type to the real subclass type.
    HYBBubbleTransition *bubble = (HYBBubbleTransition *)transition;
    // If you want to use Spring animation, set to YES.
    // Default is NO.
        bubble.animatedWithSpring = YES;
    bubble.bubbleColor = presented.view.backgroundColor;
    
    // 由于一个控制器有导航，一个没有，导致会有64的误差，所以要记得处理这种情况
    CGPoint center = [self.view viewWithTag:1010].center;
    center.y += 64;
    
    bubble.bubbleStartPoint = center;
  } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
    // Do nothing and it is ok here.
    // If you really want to do something, here you can set the mode.
    // But inside the super class, it is set to be automally.
    // So you do this has no meaning.
    transition.transitionMode = kHYBTransitionDismiss;
  }];
  vc.transitioningDelegate = self.bubbleTransition;
  
  [self presentViewController:vc animated:YES completion:NULL];
}

@end
