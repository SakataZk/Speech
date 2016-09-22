//
//  HotTopicViewController.m
//  Talking
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "HotTopicViewController.h"
#import "HotTopicCollectionViewCell.h"
#import "HotTopicCollectionViewLayout.h"
#import <AVFoundation/AVFoundation.h>


static NSString *const cellIdentifier = @"cell";

@interface HotTopicViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
HotTopicCollectionViewLayoutDelegate
>
@property (nonatomic, retain)NSMutableArray *imageArray;

@property (nonatomic, retain) UICollectionView *collectionView;
@end

@implementation HotTopicViewController


- (NSMutableArray *)handleImageArray {
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i <= 2; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpeg",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArray addObject:image];
    }
    return imageArray;
}
-(void)viewDidLoad {
    self.imageArray = [self handleImageArray];
    HotTopicCollectionViewLayout *flowLayout = [[HotTopicCollectionViewLayout alloc] init];
    flowLayout.numberOfColumn = 2;
    //  设置间距
    flowLayout.itemMergin = 5.f;
    flowLayout.delegaete = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[HotTopicCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.image = _imageArray[indexPath.item];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(HotTopicCollectionViewCell *)layout width:(CGFloat)width heightAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *image = _imageArray[indexPath.item];
    CGRect boundingRect = {0,0,width,CGFLOAT_MAX};
    //  AVFoundation框架下提供媒体图片资源自适应高度的函数
    CGRect contentRect = AVMakeRectWithAspectRatioInsideRect(image.size, boundingRect);
    return contentRect.size.height;
    
}




@end
