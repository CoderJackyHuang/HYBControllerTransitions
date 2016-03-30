//
//  HYBModalHalfController.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBModalHalfController.h"
#import "HYBModalHalfDetailController.h"
#import "HYBModalTransition.h"

@interface HYBModalHalfController ()

@property (nonatomic, strong) HYBModalTransition *transition;

@end

@implementation HYBModalHalfController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *imgView = [[UIImageView alloc] init];
  imgView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 120);
  imgView.image = [UIImage imageNamed:@"img5.jpg"];
  imgView.contentMode = UIViewContentModeScaleAspectFit;
  [self.view addSubview:imgView];
  
  self.view.backgroundColor = [UIColor whiteColor];
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake((self.view.frame.size.width - 80) / 2,
                            self.view.frame.size.height - 80 - 64,
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
  HYBModalHalfDetailController *vc = [[HYBModalHalfDetailController alloc] init];
  
  self.transition = [[HYBModalTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
    HYBModalTransition *modal = (HYBModalTransition *)transition;
    modal.scale = (CGPoint){0.95, 0.95};
    
    // If you don't specify, it will use default value
//    modal.presentedHeight = 350.0;
    
    // If you don't want to, set to YES or do no set.
    modal.shouldDismissOnTap = YES;
    
    // Default is NO, if set to YES, it will use spring animation.
    modal.animatedWithSpring = YES;
    
    // Default is YES. including navigation bar when take snapshots.
    // When has navigation bar, if set to NO, it looks not so good.
//    modal.scapshotIncludingNavigationBar = NO;
  } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
    // do nothing
    transition.transitionMode = kHYBTransitionDismiss;
  }];
  
  vc.transitioningDelegate = self.transition;
  [self presentViewController:vc animated:YES completion:NULL];
}

@end
