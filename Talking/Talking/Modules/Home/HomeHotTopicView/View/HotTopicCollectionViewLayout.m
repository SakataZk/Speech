//
//  HotTopicCollectionViewLayout.m
//  Talking
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "HotTopicCollectionViewLayout.h"

@interface HotTopicCollectionViewLayout ()
/**
 *  存储布局属性对象的数组
 */
@property (nonatomic, retain)NSMutableArray *layoutAttributesArray;

/**
 *  item的宽度
 */
@property (nonatomic, assign)CGFloat itemWidth;




@end
@implementation HotTopicCollectionViewLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _contentHeight = 0;
        
        _itemMergin = 5.0f;
        
        _labelHeight = 260;
        
        self.layoutAttributesArray = [NSMutableArray array];
    }
    return self;
}

- (CGFloat)itemWidth {
    
    //  每行所有item的宽度和 (排除item之间的间距)
    CGFloat widthOfRow = self.collectionView.bounds.size.width - (_numberOfColumn + 1) * _itemMergin;
    //  每个item的宽度
    _itemWidth = widthOfRow / _numberOfColumn;
    return _itemWidth;
    
}


//  准备布局的方法
- (void)prepareLayout {
    
    //  如果多次加载布局, 需要先清空原有布局属性
    if (_layoutAttributesArray.count > 0) {
        [_layoutAttributesArray removeAllObjects];
    }
    //  有多少个cell (创建对应个数的layoutAttributes)
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //  高度最小的列 (初始值为0)
    NSInteger minHeightColumn = 0;
    
    CGFloat *heightOfColumnArray = malloc(sizeof(CGFloat) * _numberOfColumn);
    
    for (int i = 0; i < _numberOfColumn; i++) {
        heightOfColumnArray[i] = 0;
    }
    for (int i = 0 ; i < count; i++) {
        //  创建对应位置的layoutAttributes
        UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        //  y坐标从数组中取出当前列的高度, 在此基础之上加上一个item间距
        CGFloat y = heightOfColumnArray[minHeightColumn];
        
        CGFloat width = self.itemWidth;
        
        CGFloat x = (width + _itemMergin) * minHeightColumn + _itemMergin;
        
        CGFloat height = [self.delegaete collectionView:self.collectionView layout:self width:width heightAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]] + _labelHeight;
        
        //  设置layoutAttributes的布局
        layoutAttributes.frame = CGRectMake(x, y, width, height);
        
        //  更新当前列数组中存储的高度
        heightOfColumnArray[minHeightColumn] = heightOfColumnArray[minHeightColumn] + height + _itemMergin ;
        
        //  更新滚动范围高度
        _contentHeight = MAX(_contentHeight, heightOfColumnArray[minHeightColumn] );
        
        //  更新最小列数
        for (int i = 0; i < _numberOfColumn; i++) {
            if (heightOfColumnArray[minHeightColumn] > heightOfColumnArray[i]) {
                minHeightColumn = i;
            }
        }
        //  添加至数组
        [_layoutAttributesArray addObject:layoutAttributes];
    }
    if ( NULL != heightOfColumnArray) {
        free(heightOfColumnArray);
        heightOfColumnArray = NULL;
    }
}
//  返回所有cell的布局属性对象
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return _layoutAttributesArray;
}
//  返回collectionView的滚动范围
- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.bounds.size.width, _contentHeight + _itemMergin );
}













@end
