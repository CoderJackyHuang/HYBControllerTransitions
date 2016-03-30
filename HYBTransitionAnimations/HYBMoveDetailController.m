//
//  HYBMoveDetailController.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBMoveDetailController.h"
#import "HYBMoveTransition.h"

@implementation HYBMoveDetailController

- (instancetype)init {
  if (self = [super init]) {

  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *imgView = [[UIImageView alloc] init];
  imgView.frame = CGRectMake(20, 40, self.view.frame.size.width - 40, self.view.frame.size.width - 40);
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"move detail";
  imgView.image = self.image;
      [self.view addSubview:imgView];

  
  // You must specify a target view with this.
  self.hyb_toTargetView = imgView;
  
  UILabel *label = [[UILabel alloc] init];
  label.frame = (CGRect){0, imgView.frame.origin.y + imgView.frame.size.height, self.view.bounds.size.width, 80};
  label.text = @"标哥的技术博客";
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont boldSystemFontOfSize:30];
  label.textColor = [UIColor blackColor];
  [self.view addSubview:label];
  
  CGFloat y = label.frame.origin.y + label.frame.size.height;
  label = [[UILabel alloc] init];
  label.frame = (CGRect){30, y, self.view.bounds.size.width - 60, 100};
  label.text = @"In this controller, you must specify a target view. Here use the image view. So it use like this: self.hyb_toTargetView = imgView";
  label.numberOfLines = 0;
  label.textAlignment = NSTextAlignmentLeft;
  label.font = [UIFont boldSystemFontOfSize:20];
  label.textColor = [UIColor blackColor];
  [self.view addSubview:label];
}

@end
