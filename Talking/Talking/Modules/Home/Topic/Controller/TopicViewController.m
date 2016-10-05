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
#import "EverydayCardView.h"
#import "AlbumModel.h"

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

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *cidArray;
@property (nonatomic, strong) EverydayCardView *firtsCardView;
@property (nonatomic, strong) NSArray *cardArray;
@property (nonatomic, assign) NSInteger cidCount;

@end
@implementation TopicViewController

- (void)viewDidLoad {
    
    self.titleArray = [NSMutableArray array];
    self.titleModelArray = [NSMutableArray array];
    self.cellInfoArray = [NSMutableArray array];
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.imageArray = [[NSMutableArray alloc] init];
    self.classArray = [NSMutableArray array];
    self.array = [NSMutableArray array];
    self.cidArray = [NSMutableArray array];
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

- (void)setAnimationImageView {
    self.imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor whiteColor];
    _imageView.frame = _bigScrollView.bounds;
    [_bigScrollView addSubview:_imageView];
    if (_imageArray.count > 0) {
        NSMutableArray *imageViewArray = [NSMutableArray array];
        for (int i = 0; i < _imageArray.count; i++) {
            NSURL *url = [NSURL URLWithString:_imageArray[i]];
            UIImage *imge = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
            [imageViewArray addObject:imge];
        }
        [self.imageView isAnimating];
        [self.imageView setAnimationImages:imageViewArray];
        [self.imageView setAnimationDuration:3.0f * imageViewArray.count];
        [self.imageView startAnimating];
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
            NSLog(@"点击了");
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
    if ([collectionView isEqual: _cardCollectionView]) {
        _cidCount = indexPath.item;
        [self GetCardInfo:_cidArray[_cidCount]];
        [self creatCardView];
        
    }
}

- (void)GetTopicInfo {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/topic_section/card?uid=189186&tsid=%ld",_topicType];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_cellInfoArray.count > 0) {
            [_cellInfoArray removeAllObjects];
        }
        if (_imageArray.count > 0) {
            [_imageArray removeAllObjects];
        }
        if (_cidArray.count > 0) {
            [_cidArray removeAllObjects];
        }
        for (NSDictionary *dic in [responseObject objectForKey:@"cards"]) {
            EverydayCellModel *model = [[EverydayCellModel alloc] initWithDic:dic];
            [_cellInfoArray addObject:model];
            [_cidArray addObject:model.cid];
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
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
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
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
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

- (void)GetCardInfo:(NSNumber *)cid{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/card/select_by_cids?cids=%@",cid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _array = [responseObject objectForKey:@"cards"];
        
        NSDictionary *dic = [_array firstObject];
        AlbumModel *model = [[AlbumModel alloc] initWithDic:dic];
        _firtsCardView.model = model;


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)creatCardView {
    self.navigationController.navigationBarHidden = YES;
    self.view.userInteractionEnabled = YES;
    _cardCollectionView.scrollEnabled = NO;
    _bigScrollView.scrollEnabled = NO;
    self.firtsCardView = [[EverydayCardView alloc] initWithFrame:SCREEN_RECT];
    [self.view addSubview:_firtsCardView];
    
    UISwipeGestureRecognizer *firstLeftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(firstLeftAction)];
    firstLeftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_firtsCardView addGestureRecognizer:firstLeftSwipe];

    UISwipeGestureRecognizer *firstDownSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipeAction)];
    firstDownSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_firtsCardView addGestureRecognizer:firstDownSwipe];
}

- (void)downSwipeAction {
    _firtsCardView.hidden = YES;
    _cardCollectionView.scrollEnabled = YES;
    _bigScrollView.scrollEnabled = YES;
    self.navigationController.navigationBarHidden = NO;
}

- (void)firstLeftAction{
    _cidCount ++;
    if (_cidCount < _cidArray.count) {
        [self GetCardInfo:_cidArray[_cidCount]];
        CATransition  *transition = [[CATransition alloc] init];
        transition.duration = 1.f;
        transition.type = @"reveal";
        transition.subtype = kCATransitionFromRight;
        [self.view.layer addAnimation:transition forKey:@"ll"];
    }
}



@end
