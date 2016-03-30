//
//  HYBBubbleRightViewController.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBBubbleRightViewController.h"

@implementation HYBBubbleRightViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  UILabel *label = [[UILabel alloc] init];
  label.frame = (CGRect){0, 180, self.view.bounds.size.width, 80};
  label.text = @"标哥的技术博客";
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont boldSystemFontOfSize:30];
  label.textColor = [UIColor whiteColor];
  [self.view addSubview:label];
  
  label = [[UILabel alloc] init];
  label.frame = (CGRect){30, 260, self.view.bounds.size.width - 60, 80};
  label.text = @"Bubble from the bottom of view.";
  label.numberOfLines = 0;
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont boldSystemFontOfSize:30];
  label.textColor = [UIColor whiteColor];
  [self.view addSubview:label];
  
  self.view.backgroundColor = [UIColor purpleColor];
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(self.view.frame.size.width - 80,
                            80,
                            80,
                            80);
  [button setTitle:@"+" forState:UIControlStateNormal];
  [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
  button.backgroundColor = [UIColor whiteColor];
  button.titleLabel.font = [UIFont boldSystemFontOfSize:60];
  [self.view addSubview:button];
  button.layer.cornerRadius = 40;
  button.tag = 1010;
  [button addTarget:self
             action:@selector(dismiss)
   forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismiss {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
