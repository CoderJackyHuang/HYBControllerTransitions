//
//  HYBGridViewController.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBMoveViewController.h"
#import "HYBGridCell.h"
#import "HYBGridModel.h"
#import "HYBMoveTransition.h"
#import "HYBMoveDetailController.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

static NSString *cellIdentifier = @"gridcellidentifier";

@interface HYBMoveViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, strong) HYBMoveTransition *transition;

@end

@implementation HYBMoveViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.itemSize = CGSizeMake((kScreenWidth - 30) / 2, (kScreenWidth - 30) / 2 + 20);
  layout.minimumLineSpacing = 10;
  layout.minimumInteritemSpacing = 10;
  
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                           collectionViewLayout:layout];
  [self.view addSubview:self.collectionView];
  [self.collectionView registerClass:[HYBGridCell class]
          forCellWithReuseIdentifier:cellIdentifier];
  self.collectionView.delegate = self;
  self.collectionView.backgroundColor = [UIColor blackColor];
  self.collectionView.dataSource = self;
  
  int j = 0;
  for (NSUInteger i = 0; i < 60; ++i) {
    if (++j > 12) {
      j = 1;
    }
    HYBGridModel *model = [[HYBGridModel alloc] init];
    model.imageName = [NSString stringWithFormat:@"img%d.jpg", j];
    model.title = [NSString stringWithFormat:@"item%ld", i];
    [self.datasource addObject:model];
  }
  
  [self.collectionView reloadData];
}

- (NSMutableArray *)datasource {
  if (_datasource == nil) {
    _datasource = [[NSMutableArray alloc] init];
  }
  
  return _datasource;
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  HYBGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                         forIndexPath:indexPath];
  HYBGridModel *model = self.datasource[indexPath.item];
  [cell configCellWithModel:model];
  
  return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.datasource.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HYBMoveDetailController *vc = [[HYBMoveDetailController alloc] init];
   HYBGridModel *model = self.datasource[indexPath.item];
  vc.image = model.clipedImage;
  
  self.transition = [[HYBMoveTransition alloc] initWithPushed:^(UIViewController *fromVC, UIViewController *toVC, HYBBaseTransition *transition) {
    HYBMoveTransition *move = (HYBMoveTransition *)transition;
    HYBGridCell *cell = (HYBGridCell *)[collectionView cellForItemAtIndexPath:indexPath];
    move.targetClickedView = cell.imageView;
    
    move.animatedWithSpring = YES;
  } poped:^(UIViewController *fromVC, UIViewController *toVC, HYBBaseTransition *transition) {
    // Do nothing, unless you really need to.
  }];
  

  self.navigationController.delegate = self.transition;
  [self.navigationController pushViewController:vc animated:YES];
}

@end
