//
//  HotTopicCollectionViewLayout.h
//  Talking
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotTopicCollectionViewLayout;
@protocol HotTopicCollectionViewLayoutDelegate <NSObject>

- (CGFloat)collectionView: (UICollectionView *)collectionView layout:(HotTopicCollectionViewLayout *)layout width: (CGFloat)width heightAtIndexPath: (NSIndexPath *)indexPath;

@end


@interface HotTopicCollectionViewLayout : UICollectionViewLayout
/**
 *  提供列数
 */
@property (nonatomic, assign) NSInteger numberOfColumn;
/**
 *  提供每个item之间的间距
 */
@property (nonatomic, assign) CGFloat itemMergin;
/**
 *  图片下方label的高度
 */
@property (nonatomic, assign)CGFloat labelHeight;
/**
 *  滚动范围高度
 */
@property (nonatomic, assign)CGFloat contentHeight;


@property (nonatomic, assign) id<HotTopicCollectionViewLayoutDelegate>delegaete;

@end
