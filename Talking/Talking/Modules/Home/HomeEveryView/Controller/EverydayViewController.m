//
//  EverydayViewController.m
//  Talking
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "EverydayViewController.h"
#import "EverydayCollectionViewCell.h"
#import "EverydayCellModel.h"
#import "EverydayCardView.h"

static NSString *const cellIdentifier = @"cell";

@interface EverydayViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, strong) NSMutableDictionary *cellDic;
@property (nonatomic, strong) NSMutableArray *cellInfoArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, assign) NSInteger cout;
@property (nonatomic, strong) NSMutableArray *cidsArray;
@property (nonatomic, strong) EverydayCardView *firstView;
@property (nonatomic, strong) EverydayCardView *secondView;
@end


@implementation EverydayViewController
- (void)viewDidLoad {
    [self netWorking];
    self.cellInfoArray = [NSMutableArray array];
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.array = [NSArray array];
    self.cidsArray = [NSMutableArray array];
    self.cout = 0;
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((self.view.width - 15) / 2, self.view.height / 2);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0, self.view.width - 10, self.view.height - 84 - self.view.height * 0.07 - 5) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
//    self.firstView = [[EverydayCardView alloc] initWithFrame:CGRectZero];
//    _firstView.backgroundColor = [UIColor redColor];
////    _firstView.hidden = YES;
//    [self.view addSubview:_firstView];
//    
//    UISwipeGestureRecognizer *firtsSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(firstSwipe)];
//    firtsSwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    [_firstView addGestureRecognizer:firtsSwipeLeft];
//    
//    
//    self.secondView = [[EverydayCardView alloc] initWithFrame:CGRectMake(self.view.width * 0.2, self.view.height * 0.1, self.view.width * 0.6, self.view.height * 0.6)];
//    _secondView.backgroundColor = [UIColor yellowColor];
//    _secondView.hidden = YES;
//    [self.view addSubview:_secondView];
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _cellInfoArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _cellInfoArray[indexPath.row];
    EverydayCellModel *everyday = [[EverydayCellModel alloc] initWithDic:dic];
    
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%ld",everyday.template]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%ld",everyday.template];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%ld",everyday.template]];
        [_collectionView registerClass:[EverydayCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    EverydayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    cell.everydayCell = everyday;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)netWorking {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6B72B3B832A054648EB2B435216FF109CD" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = @"http://app.ry.api.renyan.cn/rest/auth/selection/card/get/all";
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_cellInfoArray.count > 0) {
            [_cellInfoArray removeAllObjects];
        }
        NSArray *array = [responseObject objectForKey:@"cards"];
        for (NSDictionary *dic in array) {
            EverydayCellModel *model = [[EverydayCellModel alloc] initWithDic:dic];
            [_cidsArray addObject:model.cid];
        }
        _cellInfoArray = [[responseObject objectForKey:@"cards"] mutableCopy];
        [_collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual:_collectionView]) {
        if (_collectionView.contentOffset.y > (_cellInfoArray.count * (self.view.height / 12 * 5 )) / 2 + (_cellInfoArray.count - 1) * 5 - (self.view.height - 84 - self.view.height * 0.07 - 5)) {
            _cout++;
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
            [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6B72B3B832A054648EB2B435216FF109CD" forHTTPHeaderField:@"X-AuthToken"];
            [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
            
            NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/selection/card/get/all?day=%ld",_cout];
            [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                _array =[responseObject objectForKey:@"cards"];
                [_cellInfoArray addObjectsFromArray:_array];
                [_collectionView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error : %@",error);
            }];

        }
    }





}

- (void)GetCard :(NSNumber *)cid{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6B72B3B832A054648EB2B435216FF109CD" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/card/select_by_cids?cids=%@",cid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}




//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//        NSNumber *cid = _cidsArray[indexPath.item];
//        [self GetCard:cid];
//        self.navigationController.navigationBarHidden = YES;
////        _firstView.hidden = NO;
//    _collectionView.hidden = YES;
//    _firstView.frame =  CGRectMake(self.view.width * 0.2, self.view.height * 0.1, self.view.width * 0.6, self.view.height * 0.6);
//}








@end
