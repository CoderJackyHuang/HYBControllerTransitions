//
//  HYBEaseInOutController.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/4/6.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBEaseInOutController.h"
#import "HYBEaseInOutDetailController.h"
#import "HYBEaseInOutTransition.h"

@interface HYBEaseInOutController ()

@property (nonatomic, strong) HYBEaseInOutTransition *transition;

@end

@implementation HYBEaseInOutController

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
  HYBEaseInOutDetailController *vc = [[HYBEaseInOutDetailController alloc] init];
  
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  self.transition = [[HYBEaseInOutTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
    HYBEaseInOutTransition *modal = (HYBEaseInOutTransition *)transition;
    
    // If you don't specify, it will use default value
    // Default is NO, if set to YES, it will use spring animation.
    modal.animatedWithSpring = NO;
  } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
    // do nothing
  }];
  
  nav.transitioningDelegate = self.transition;
  [self presentViewController:nav animated:YES completion:NULL];
}

@end
