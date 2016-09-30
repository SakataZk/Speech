//
//  TopicViewController.m
//  Talking
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "TopicViewController.h"
#import "TitleCollectionCell.h"
#import "TitleModel.h"
#import "EverydayCellModel.h"
#import "EverydayCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ClassModel.h"

static NSString *const cellIdentifier = @"titleCell";

@interface TopicViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UIScrollViewDelegate
>

@property (nonatomic ,strong) UICollectionView *titleCollectionView;
@property (nonatomic, strong) NSMutableArray *titleModelArray;
@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) UIScrollView *bigScrollView;
@property (nonatomic, assign) NSInteger topicType;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UICollectionView *cardCollectionView;
@property (nonatomic, strong) NSMutableArray *cellInfoArray;
@property (nonatomic, strong) NSMutableDictionary *cellDic;

@property (nonatomic, strong) NSMutableArray *classArray;
@property (nonatomic, strong) UICollectionView *classCollectionView;


@end
@implementation TopicViewController

- (void)viewDidLoad {
    
    self.titleArray = [NSMutableArray array];
    self.titleModelArray = [NSMutableArray array];
    self.cellInfoArray = [NSMutableArray array];
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.imageArray = [[NSMutableArray alloc] init];
    self.classArray = [NSMutableArray array];
    self.topicType = 0;
    [self GetTitleArray];
    
    UICollectionViewFlowLayout *titleCellFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    titleCellFlowLayout.itemSize = CGSizeMake(self.view.width / 5, self.view.height * 0.07);
    titleCellFlowLayout.minimumLineSpacing = 0;
    titleCellFlowLayout.minimumInteritemSpacing = 0;
    
    self.titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.07) collectionViewLayout:titleCellFlowLayout];
    _titleCollectionView.backgroundColor = [UIColor whiteColor];
    _titleCollectionView.delegate = self;
    _titleCollectionView.dataSource = self;

    
    [self.view addSubview:_titleCollectionView];
    
    [_titleCollectionView registerClass:[TitleCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    
    self.bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _titleCollectionView.y + _titleCollectionView.height, self.view.width, (self.view.height - _titleCollectionView.y - _titleCollectionView.height - self.navigationController.navigationBar.y - self.navigationController.navigationBar.height) / 2 )];
    
    _bigScrollView.contentSize = CGSizeMake(self.view.width * 5, _bigScrollView.height);
    _bigScrollView.pagingEnabled = YES;
    _bigScrollView.delegate = self;
    [self.view addSubview:_bigScrollView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.width * 0.4, self.view.height - _bigScrollView.height - _bigScrollView.y - self.navigationController.navigationBar.height - self.navigationController.navigationBar.y);
    flowLayout.minimumLineSpacing = 2;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.cardCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _bigScrollView.y + _bigScrollView.height, self.view.width, self.view.height - _bigScrollView.height - _bigScrollView.y - self.navigationController.navigationBar.height - self.navigationController.navigationBar.y) collectionViewLayout:flowLayout];
    _cardCollectionView.delegate = self;
    _cardCollectionView.dataSource = self;
    _cardCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_cardCollectionView];
    
    
    
    

    
    
    
    
    
    
    self.number = 0;

}
//  18640907975



- (void)setAnimationImageView {
    
    self.imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor whiteColor];
    _imageView.frame = _bigScrollView.bounds;
    [_bigScrollView addSubview:_imageView];
    if (_imageArray.count > 0) {
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"image"];
        CGMutablePathRef path = CGPathCreateMutable();
        
        NSMutableArray *time = [NSMutableArray array];
        for (int i = 0; i < _imageArray.count; i++) {
            NSURL *url = [NSURL URLWithString:_imageArray[i]];;
            UIImageView *imagev = [[UIImageView alloc] initWithFrame:_imageView.bounds];
            [imagev sd_setImageWithURL:url];
            NSNumber *count = @( i / (_imageArray.count * 1.0f) );
            [_imageView addSubview:imagev];
            [time addObject:count];
        }
        keyAnimation.keyTimes = time;
        keyAnimation.path = path;
        keyAnimation.beginTime=CACurrentMediaTime()+2;
        keyAnimation.duration = 3.0f * _imageArray.count;
        [_imageView.layer addAnimation:keyAnimation forKey:@"image"];
    }
}

- (void)selectFirstTitle {
    if (_titleModelArray.count > 0) {
        
        TitleCollectionCell *cell = (TitleCollectionCell *)[_titleCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        cell.label.textColor = [UIColor blackColor];
        TitleModel *model = _titleModelArray[0];
        _topicType = model.tsid;
        [self GetTopicInfo];
    }
}

//  结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_bigScrollView]) {
        NSInteger pageNumber = _bigScrollView.contentOffset.x / SCREEN_WIDTH;
        if (pageNumber < _titleArray.count - 1) {
            
            TitleModel *model = _titleModelArray[pageNumber];
            _topicType = model.tsid;
            [self GetTopicInfo];
        }
        [_titleCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:pageNumber inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredVertically];
        
        NSArray *indexPathArray = [_titleCollectionView indexPathsForVisibleItems];
        for (NSIndexPath *indexPath in indexPathArray) {
            TitleCollectionCell *cell = (TitleCollectionCell *)[_titleCollectionView cellForItemAtIndexPath:indexPath];
            cell.label.textColor = [UIColor lightGrayColor];
        }
        TitleCollectionCell *cell = (TitleCollectionCell *)[_titleCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:pageNumber inSection:0]];
        cell.label.textColor = [UIColor blackColor];
    }
    
    }


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:_titleCollectionView]) {

        return _titleArray.count;
    }
    return _cellInfoArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([collectionView isEqual:_titleCollectionView]) {
        TitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.label.textColor = [UIColor blackColor];
        }
        cell.text = _titleArray[indexPath.row];
        return cell;
    }
    EverydayCellModel *cellInfo = _cellInfoArray[indexPath.row];
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%ld",cellInfo.template]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%ld",cellInfo.template];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%ld",cellInfo.template]];
        [_cardCollectionView registerClass:[EverydayCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    EverydayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.everydayCell = _cellInfoArray[indexPath.item];
    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:_titleCollectionView]) {
        TitleCollectionCell *cell = (TitleCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.label.textColor = [UIColor blackColor];
        if (indexPath.row < _titleArray.count) {
            NSArray *indexPathArray = [_titleCollectionView indexPathsForVisibleItems];
            for (NSIndexPath *MyIndexPath in indexPathArray) {
                TitleCollectionCell *cell = (TitleCollectionCell *)[_titleCollectionView cellForItemAtIndexPath:MyIndexPath];
                cell.label.textColor = [UIColor lightGrayColor];
            }
            TitleCollectionCell *cell = (TitleCollectionCell *)[_titleCollectionView cellForItemAtIndexPath:indexPath];
            cell.label.textColor = [UIColor blackColor];
            _bigScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * indexPath.item, 0);
        }
        
        
        if (indexPath.row < _titleArray.count - 1) {
            TitleModel *model = _titleModelArray[indexPath.row];
            _topicType = model.tsid;
            [self GetTopicInfo];
        } else {
            [self GetClassArray];
        }
    }
}

- (void)GetTopicInfo {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6B72B3B832A054648EB2B435216FF109CD" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/topic_section/card?uid=189186&tsid=%ld",_topicType];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_cellInfoArray.count > 0) {
            [_cellInfoArray removeAllObjects];
        }
        if (_imageArray.count > 0) {
            [_imageArray removeAllObjects];
        }
        for (NSDictionary *dic in [responseObject objectForKey:@"cards"]) {
            EverydayCellModel *model = [[EverydayCellModel alloc] initWithDic:dic];
            [_cellInfoArray addObject:model];
            
            
            if ( ![model.pictureCut isEqualToString:@""]) {
                [_imageArray addObject:model.pictureCut];
            }
            
        }
        [_cardCollectionView reloadData];
    
        _number = 0;
        [self setAnimationImageView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)GetTitleArray{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6B72B3B832A054648EB2B435216FF109CD" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/topic_section/available"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array =[responseObject objectForKey:@"topicSections"];
        
        for (NSDictionary *dic in array) {
            TitleModel *title = [[TitleModel alloc] initWithDic:dic];
            [_titleArray addObject:title.name];
            [_titleModelArray addObject:title];
        }
        [_titleArray addObject:@"分类"];
        [self selectFirstTitle];
        [_titleCollectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)GetClassArray{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6B72B3B832A054648EB2B435216FF109CD" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/classification/tag/available"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [NSArray arrayWithArray: [responseObject objectForKey:@"classificationTags"]];
        for (NSDictionary *dic in array) {
            [_classArray addObject:[dic objectForKey:@"tid"]];
        }
        NSLog(@"%@",_classArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}



@end
