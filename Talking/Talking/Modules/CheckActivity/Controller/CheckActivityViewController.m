//
//  CheckActivityViewController.m
//  
//
//  Created by dllo on 16/9/28.
//
//

#import "CheckActivityViewController.h"
#import "ActivityModel.h"
#import "TalkingCollectionViewCell.h"
#import "EverydayCellModel.h"
#import "EverydayCollectionViewCell.h"
#import "EverydayCardView.h"
#import "AlbumModel.h"

static NSString *const cellIdentifier = @"cell";
@interface CheckActivityViewController ()
<
UIScrollViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, strong) UICollectionView *scrollCollectionView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *currentArray;
@property (nonatomic, strong) NSMutableArray *cidArray;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *cellInfoArray;
@property (nonatomic, strong) NSMutableDictionary *cellDic;

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) EverydayCardView *firtsCardView;
@property (nonatomic, strong) NSArray *cardArray;
@property (nonatomic, assign) NSInteger cidCount;
@end

@implementation CheckActivityViewController
- (void)viewDidLoad {

    [super viewDidLoad];
    self.imageArray = [NSMutableArray array];
    self.currentArray = [NSMutableArray array];
    self.cellInfoArray = [NSMutableArray array];
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.cidArray = [NSMutableArray array];
    self.array = [NSMutableArray array];
    self.cardArray = [NSArray array];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.08)];
    //    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.userInteractionEnabled = YES;
    titleLabel.text = _model.name;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.frame = CGRectMake(self.view.width * 0.055, 0, self.view.width * 0.055, titleLabel.height / 2);
    returnButton.centerY = titleLabel.centerY;
    [returnButton setImage:[UIImage imageNamed:@"darkReturn"] forState:UIControlStateNormal];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [titleLabel addSubview:returnButton];
    
    
    [self GetInfo];
    
    UICollectionViewFlowLayout *scrollFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    scrollFlowLayout.itemSize = CGSizeMake(self.view.width,( self.view.height - titleLabel.height ) /  2);
    scrollFlowLayout.minimumInteritemSpacing = 0;
    scrollFlowLayout.minimumLineSpacing = 0;
    scrollFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.scrollCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, titleLabel.height, self.view.width, ( self.view.height - titleLabel.height ) /  2) collectionViewLayout:scrollFlowLayout];
    _scrollCollectionView.delegate = self;
    _scrollCollectionView.dataSource = self;
    _scrollCollectionView.pagingEnabled = YES;
    _scrollCollectionView.contentSize = CGSizeMake(self.view.width * _imageArray.count, ( self.view.height - self.navigationController.navigationBar.height ) /  2);
    _scrollCollectionView.backgroundColor = [UIColor whiteColor];
    _scrollCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollCollectionView];
    [_scrollCollectionView registerClass:[TalkingCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    
   
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.width * 0.4, self.view.height - _scrollCollectionView.height - titleLabel.height);
    flowLayout.minimumLineSpacing = 2;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _scrollCollectionView.y + _scrollCollectionView.height, self.view.width, self.view.height - _scrollCollectionView.height - _scrollCollectionView.y - self.navigationController.navigationBar.height - self.navigationController.navigationBar.y) collectionViewLayout:flowLayout];
    _collectionView.contentSize = CGSizeMake((self.view.width * 0.4 + 2) * _cellInfoArray.count - 2,  self.view.height - _scrollCollectionView.height - titleLabel.height);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
    
    if (_timer) {
        [_timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)closeTimer {
    [_timer invalidate];
}

- (void)timerAction:(NSTimer *)timer {
    
    NSInteger pageNumber = _scrollCollectionView.contentOffset.x / SCREEN_WIDTH;
    if (_imageArray.count == pageNumber) {
        pageNumber = 0;
        _scrollCollectionView.contentOffset = CGPointMake(pageNumber * SCREEN_WIDTH, 0);
    }
    [_scrollCollectionView setContentOffset:CGPointMake((pageNumber + 1) * SCREEN_WIDTH, 0) animated:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollCollectionView]) {
        [_timer setFireDate:[NSDate distantPast]];
    }
}

- (void)GetInfo {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6B72B3B832A054648EB2B435216FF109CD" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/activity/get_cards?limit=10&tpid=%@",_model.tpid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_cellInfoArray.count > 0) {
            [_cellInfoArray removeAllObjects];
        }
        if (_imageArray.count > 0) {
            [_imageArray removeAllObjects];
        }
        if (_currentArray.count > 0) {
            [_currentArray removeAllObjects];
        }
        if (_cidArray.count > 0) {
            [_cidArray removeAllObjects];
        }
        for (NSDictionary *dic in [responseObject objectForKey:@"cards"]) {
            EverydayCellModel *model = [[EverydayCellModel alloc] initWithDic:dic];
            [_cellInfoArray addObject:model];
            [_cidArray addObject:model.cid];
            if (model.pictureCut != nil) {
                [_imageArray addObject:model.pictureCut];
            }
        }
        [_currentArray addObject:[_imageArray lastObject]];
        [_currentArray addObjectsFromArray:_imageArray];
        [_currentArray addObject:[_imageArray firstObject]];
        _scrollCollectionView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        
        [_scrollCollectionView reloadData];
        [_collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];

}

- (void)addMoreCard {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6B72B3B832A054648EB2B435216FF109CD" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/activity/get_cards?lastCid=%@&limit=10&tpid=%@",[_cidArray lastObject],_model.tpid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        if (_currentArray.count > 0) {
            [_currentArray removeAllObjects];
        }
        for (NSDictionary *dic in [responseObject objectForKey:@"cards"]) {
            EverydayCellModel *model = [[EverydayCellModel alloc] initWithDic:dic];
            [_cellInfoArray addObject:model];
            [_cidArray addObject:model.cid];
            if (model.pictureCut != nil) {
                [_imageArray addObject:model.pictureCut];
            }
        }
        [_currentArray addObject:[_imageArray lastObject]];
        [_currentArray addObjectsFromArray:_imageArray];
        [_currentArray addObject:[_imageArray firstObject]];
        _scrollCollectionView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        
        [_scrollCollectionView reloadData];
        [_collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual:_scrollCollectionView]) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.0f]];
    }
    if ([scrollView isEqual:_collectionView]) {
        if (_collectionView.contentOffset.x > (_cellInfoArray.count * (self.view.width * 0.4))+ (_cellInfoArray.count - 1) * 2 - self.view.width) {
            [self addMoreCard];
        }
        if (_collectionView.contentOffset.x < 0) {
            [self GetInfo];
        }
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
        EverydayCellModel *model = _cellInfoArray[indexPath.row];
        NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%ld",model.template]];
        if (identifier == nil) {
            identifier = [NSString stringWithFormat:@"%ld",model.template];
            [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%ld",model.template]];
            [_collectionView registerClass:[EverydayCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        }
        EverydayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.everydayCell = model;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    TalkingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *imageString = _currentArray[indexPath.row];
    cell.imageString = imageString;

    return cell;


    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self creatCardView];
    _cidCount = indexPath.item;
    [self GetCardInfo:_cidArray[_cidCount]];
    
}

- (void)creatCardView {
    
    self.view.userInteractionEnabled = YES;
    _collectionView.scrollEnabled = NO;
    _scrollCollectionView.scrollEnabled = NO;
    
    
    
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
    _collectionView.scrollEnabled = YES;
    _scrollCollectionView.scrollEnabled = YES;
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
        
        
    }else {
        [self addMoreCard];
    }
}



- (void)GetCardInfo:(NSNumber *)cid{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6B72B3B832A054648EB2B435216FF109CD" forHTTPHeaderField:@"X-AuthToken"];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
