//
//  HYBGridCell.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBGridCell.h"
#import "HYBGridModel.h"

@interface HYBGridCell ()

@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation HYBGridCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.imageView = [[UIView alloc] init];
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    [self.contentView addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor blackColor];
    self.titleLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:self.titleLabel];
  }
  
  return self;
}

- (void)configCellWithModel:(HYBGridModel *)model {
  if (model.clipedImage) {
    self.imageView.layer.contents = (__bridge id _Nullable)(model.clipedImage.CGImage);
  } else {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      UIImage *image = [UIImage imageNamed:model.imageName];
      image = [self clipImage:image toSize:self.imageView.frame.size];
      dispatch_async(dispatch_get_main_queue(), ^{
        model.clipedImage = image;
        self.imageView.layer.contents = (__bridge id _Nullable)(model.clipedImage.CGImage);
      });
    });
  }
  
  self.titleLabel.text = model.title;
}


- (UIImage *)clipImage:(UIImage *)image toSize:(CGSize)size {
  UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
  
  CGSize imgSize = image.size;
  CGFloat x = MAX(size.width / imgSize.width, size.height / imgSize.height);
  CGSize resultSize = CGSizeMake(x * imgSize.width, x * imgSize.height);
  
  [image drawInRect:CGRectMake(0, 0, resultSize.width, resultSize.height)];
  
  UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return finalImage;
}

@end
