//
//  TalkingViewController.m
//  Talking
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "TalkingViewController.h"
#import "EverydayCollectionViewCell.h"
#import "EverydayCellModel.h"
#import <UIImageView+WebCache.h>
#import "TalkingCollectionViewCell.h"


static NSString *const cellIdentifier = @"cell";
@interface TalkingViewController ()
<
UIScrollViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, strong) NSMutableDictionary *cellDic;
@property (nonatomic, strong) NSMutableArray *cellInfoArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, assign) NSInteger cout;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) UICollectionView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *currentArray;
@end
@implementation TalkingViewController
- (void)viewDidLoad {
    
    [self netWorking];
    self.cellInfoArray = [NSMutableArray array];
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.array = [NSArray array];
    self.imageArray = [NSMutableArray array];
    self.currentArray = [NSMutableArray array];
    self.cout = 0;
    self.uid = 191128;
    
    UICollectionViewFlowLayout *scrollFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    scrollFlowLayout.itemSize = CGSizeMake(self.view.width, ( self.view.height - self.navigationController.navigationBar.height ) /  2);
    scrollFlowLayout.minimumInteritemSpacing = 0;
    scrollFlowLayout.minimumLineSpacing = 0;
    scrollFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.scrollView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ( self.view.height - self.navigationController.navigationBar.height ) /  2) collectionViewLayout:scrollFlowLayout];
    _scrollView.delegate = self;
    _scrollView.dataSource = self;
    _scrollView.pagingEnabled = YES;
    
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
  

    [self.view addSubview:_scrollView];
    
    [_scrollView registerClass:[TalkingCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    if (_timer) {
        [_timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.width * 0.4, self.view.height - _scrollView.height - self.navigationController.navigationBar.height - self.navigationController.navigationBar.y);
    flowLayout.minimumLineSpacing = 2;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _scrollView.y + _scrollView.height, self.view.width, self.view.height - _scrollView.height - _scrollView.y - self.navigationController.navigationBar.height - self.navigationController.navigationBar.y) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
   
}
- (void)closeTimer {
    [_timer invalidate];
}

- (void)timerAction:(NSTimer *)timer {
    
    NSInteger pageNumber = _scrollView.contentOffset.x / SCREEN_WIDTH;
    if (_imageArray.count == pageNumber) {
        pageNumber = 0;
        _scrollView.contentOffset = CGPointMake(pageNumber * SCREEN_WIDTH, 0);
    }
    [_scrollView setContentOffset:CGPointMake((pageNumber + 1) * SCREEN_WIDTH, 0) animated:YES];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollView]) {
        [_timer setFireDate:[NSDate distantPast]];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual:_scrollView]) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.0f]];
    }
    if ([scrollView isEqual:_collectionView]) {
        if (_collectionView.contentOffset.x > (_cellInfoArray.count * (self.view.width * 0.4))+ (_cellInfoArray.count - 1) * 2 - self.view.width) {
            [self addCard];
        }
        if (_collectionView.contentOffset.x < 0) {
            [self netWorking];
        }
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollView]) {
        NSInteger pageCount = scrollView.contentOffset.x / SCREEN_WIDTH;
        if (0 == pageCount) {
            pageCount = _imageArray.count;
        } else if (_imageArray.count + 1 == pageCount) {
            pageCount = 1;
        }
        scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * pageCount, 0);
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:_collectionView]) {
        return _cellInfoArray.count;
    }
    return _currentArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([collectionView isEqual:_collectionView]) {
        
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
    TalkingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *imageString = _currentArray[indexPath.row];
        cell.imageString = imageString;
    return cell;


}


- (void)netWorking {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6BEF48CA1E5A3FE3FC6C968A08F7642843" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/queue/get?count=10&uid=%ld",_uid];
    _uid++;
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_cellInfoArray.count > 0) {
            [_cellInfoArray removeAllObjects];
        }
        if (_imageArray.count > 0) {
            [_imageArray removeAllObjects];
        }
        if ([[responseObject objectForKey:@"msg"] isEqualToString:@"查询成功, 返回内容"]) {
            _array =[responseObject objectForKey:@"cards"];
            [_cellInfoArray addObjectsFromArray:_array];
        }
        for (NSDictionary *dic in _cellInfoArray) {
            EverydayCellModel *model = [[EverydayCellModel alloc] initWithDic:dic];
            if ( ![model.pictureCut isEqualToString:@""]) {
                [_imageArray addObject:model.pictureCut];
            }
        }
        
        if (_currentArray.count > 0) {
            [_currentArray removeAllObjects];
        }
        [_currentArray addObject:[_imageArray lastObject]];
        [_currentArray addObjectsFromArray:_imageArray];
        [_currentArray addObject:[_imageArray firstObject]];
        _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        
        
            if (_cellInfoArray.count < 20) {
                [self addCard];
            }
        [_scrollView reloadData];
        [_collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}


- (void)addCard {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6BEF48CA1E5A3FE3FC6C968A08F7642843" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/queue/get?count=10&uid=%ld",_uid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"msg"] isEqualToString:@"查询成功, 返回内容"]) {
            _array =[responseObject objectForKey:@"cards"];
            
            for (NSDictionary *dic in _array) {
                EverydayCellModel *model = [[EverydayCellModel alloc] initWithDic:dic];
                if ( ![model.pictureCut isEqualToString:@""]) {
                    [_imageArray addObject:model.pictureCut];
                }
            }
            [_cellInfoArray addObjectsFromArray:_array];
        }
        if (_cellInfoArray.count < 20) {
            [self addCard];
        }
        if (_currentArray.count > 0) {
            [_currentArray removeAllObjects];
        }
        [_currentArray addObject:[_imageArray firstObject]];
        [_currentArray addObjectsFromArray:_imageArray];
        [_currentArray addObject:[_imageArray lastObject]];
        [_collectionView reloadData];
        [_scrollView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];

}

















@end
