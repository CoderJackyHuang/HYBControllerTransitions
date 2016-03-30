//
//  HYBGridCell.h
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYBGridModel;

@interface HYBGridCell : UICollectionViewCell

@property (nonatomic, strong) UIView *imageView;

- (void)configCellWithModel:(HYBGridModel *)model;

@end
