//
//  HYBModalHalfDetailController.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBModalHalfDetailController.h"

@implementation HYBModalHalfDetailController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *imgView = [[UIImageView alloc] init];
  imgView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 120);
  imgView.image = [UIImage imageNamed:@"img6.jpg"];
  imgView.contentMode = UIViewContentModeScaleAspectFit;
  [self.view addSubview:imgView];
  
  self.view.backgroundColor = [UIColor whiteColor];
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake((self.view.frame.size.width - 80) / 2,
                            20,
                            80,
                            80);
  [button setTitle:@"+" forState:UIControlStateNormal];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  button.backgroundColor = [UIColor purpleColor];
  button.titleLabel.font = [UIFont boldSystemFontOfSize:60];
  [self.view addSubview:button];
  button.tag = 1010;
  button.layer.cornerRadius = 40;
  [button addTarget:self action:@selector(onDismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onDismiss {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
