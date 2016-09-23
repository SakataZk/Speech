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
#import "HotTopicModel.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>

static NSString *const cellIdentifier = @"cell";

@interface HotTopicViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
HotTopicCollectionViewLayoutDelegate
>

@property (nonatomic, strong)NSMutableArray *cellInfoArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HotTopicCollectionViewLayout *flowLayout;
@property (nonatomic ,strong) NSArray *array;
@end

@implementation HotTopicViewController


-(void)viewDidLoad {

    
    
    [self netWorking];
    self.cellInfoArray = [NSMutableArray array];
    
    self.flowLayout = [[HotTopicCollectionViewLayout alloc] init];
    _flowLayout.numberOfColumn = 2;
    //  设置间距
    _flowLayout.itemMergin = 5.f;
    _flowLayout.delegaete = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[HotTopicCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    //  下拉刷新
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_cellInfoArray removeAllObjects];
        [self netWorking];
        [_collectionView.mj_header endRefreshing];
    }];
    _collectionView.mj_header.automaticallyChangeAlpha = YES;

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual: _collectionView]) {
        if (_collectionView.contentOffset.y > _flowLayout.contentHeight - self.view.height) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
                [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6BEF48CA1E5A3FE3FC6C968A08F7642843" forHTTPHeaderField:@"X-AuthToken"];
                [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
                NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/album/queue/get?count=10&uid=189186"];
                [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSLog(@"%@",NSStringFromClass([[responseObject objectForKey:@"albums"] class]));
                        self.array =[responseObject objectForKey:@"albums"];
                        [_cellInfoArray addObjectsFromArray:_array];
                        [_collectionView reloadData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"error : %@",error);
                }];
        }
    }
}







- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cellInfoArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = _cellInfoArray[indexPath.row];
    HotTopicModel *hotTopic = [[HotTopicModel alloc] initWithDic:dic];
    cell.hotTopicCell = hotTopic;
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(HotTopicCollectionViewCell *)layout width:(CGFloat)width heightAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    HotTopicModel *hotTopic = [[HotTopicModel alloc] initWithDic:_cellInfoArray[indexPath.item]];
    height = 200 * hotTopic.imageRatio;
    return height;
}

- (void)netWorking {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6BEF48CA1E5A3FE3FC6C968A08F7642843" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = @"http://app.ry.api.renyan.cn/rest/auth/album/queue/get?count=10&uid=189186";
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_cellInfoArray.count > 0) {
            [_cellInfoArray removeAllObjects];
        }
        _flowLayout.contentHeight = 0;
        _cellInfoArray = [[responseObject objectForKey:@"albums"] mutableCopy];
        [_collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}


@end
