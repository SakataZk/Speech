
//
//  AlbumViewController.m
//  Talking
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "AlbumViewController.h"
#import "HotTopicModel.h"
#import "UIImageView+WebCache.h"
#import "AlbumCollectionViewCell.h"
#import "AlbumModel.h"
#import "AlbumCardCollectionViewCell.h"
#import "UserViewController.h"


static NSString *const cellIdentifier = @"cell";
static NSString *const cardCellIdentifier = @"cardCell";
@interface AlbumViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, strong) UIScrollView *bigScrollView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *albumArray;

@property (nonatomic, strong) UIScrollView *bigView;

@property (nonatomic, strong) UICollectionView *bigCollectionView;
@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.albumArray = [NSMutableArray array];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self CreatBackgroudView];
    [self netWorking];
    [self CreatScrollView];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(self.view.width * 0.75, self.view.height * 0.92, self.view.width * 0.06, self.view.width * 0.05);
    [self.view addSubview:shareButton];
    
    UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(shareButton.x, shareButton.y + shareButton.height * 1.5, shareButton.width, shareButton.height / 2)];
    shareLabel.text = @"分享";
    shareLabel.textColor = [UIColor lightGrayColor];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:shareLabel];
    
    
    UIButton *attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [attentionButton setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateNormal];
    attentionButton.frame = CGRectMake(self.view.width * 0.84, shareButton.y, shareButton.width, shareButton.height);
    [self.view addSubview:attentionButton];
    
    UILabel *attentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(attentionButton.x, attentionButton.y + attentionButton.height * 1.5, attentionButton.width, attentionButton.height / 2)];
    attentionLabel.text = @"关注";
    attentionLabel.textColor = [UIColor lightGrayColor];
    attentionLabel.textAlignment = NSTextAlignmentCenter;
    attentionLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:attentionLabel];
    
    self.bigView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _bigView.userInteractionEnabled = YES;
    _bigView.pagingEnabled = YES;
    [self.view addSubview:_bigView];

    
    
    UICollectionViewFlowLayout *bigFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    bigFlowLayout.itemSize = CGSizeMake( self.view.width - 10, self.view.height - 10);
    bigFlowLayout.minimumLineSpacing = 10;
    bigFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.bigCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0,(self.view.width) , self.view.height - 10) collectionViewLayout:bigFlowLayout];
    _bigCollectionView.scrollEnabled = NO;
    _bigCollectionView.showsHorizontalScrollIndicator = NO;
    _bigCollectionView.delegate = self;
    _bigCollectionView.dataSource = self;
    _bigCollectionView.backgroundColor = [UIColor clearColor];
    _bigCollectionView.contentSize = CGSizeMake((self.view.width - 10) * _albumArray.count, 0);
    [_bigView addSubview:_bigCollectionView];
    
    [_bigCollectionView registerClass:[AlbumCardCollectionViewCell class] forCellWithReuseIdentifier:cardCellIdentifier];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    [_bigCollectionView addGestureRecognizer:swipe];
    
    
    
    
    
    // Do any additional setup after loading the view.
}
- (void)swipeAction{
[UIView animateWithDuration:1.0f animations:^{
    _bigScrollView.scrollEnabled = YES;
    _bigView.frame = CGRectZero;
}];



}

- (void)CreatBackgroudView {
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height *0.3)];
    backgroundImage.backgroundColor = [UIColor greenColor];
    backgroundImage.userInteractionEnabled = YES;
    NSURL *url = [NSURL URLWithString:_hotTopic.coverSmall];
    [backgroundImage sd_setImageWithURL:url];
    [self.view addSubview:backgroundImage];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.frame = CGRectMake(self.view.width * 0.055, self.view.height * 0.047, self.view.width * 0.06, self.view.height * 0.04);
    [returnButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    returnButton.backgroundColor = [UIColor clearColor];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [backgroundImage addSubview:returnButton];
    
    UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, returnButton.y, self.view.width * 0.8, returnButton.height)];
    nickNameLabel.centerX = self.view.centerX;
    nickNameLabel.backgroundColor = [UIColor clearColor];
    nickNameLabel.text = [NSString stringWithFormat:@"「 %@ 」",_hotTopic.name];
    nickNameLabel.textAlignment = NSTextAlignmentCenter;
    nickNameLabel.textColor = [UIColor whiteColor];
    nickNameLabel.font = [UIFont systemFontOfSize:18];
    [backgroundImage addSubview:nickNameLabel];
    
    UIView *imageView = [[UIView alloc] init];
        imageView.frame = CGRectMake(self.view.width - returnButton.x - returnButton.width * 2, returnButton.y - returnButton.width / 2, returnButton.width * 2, returnButton.width * 2);
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.layer.cornerRadius = returnButton.width;
    imageView.clipsToBounds = YES;
    [backgroundImage addSubview:imageView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, returnButton.width * 2 - 5, returnButton.width * 2 - 5)];
    headImage.backgroundColor = [UIColor redColor];
    headImage.center = imageView.center;
    headImage.layer.cornerRadius = (returnButton.width * 2 - 5) / 2;
    headImage.clipsToBounds = YES;
    headImage.userInteractionEnabled = YES;
    NSURL *headUrl = [NSURL URLWithString:_hotTopic.ownerProfile];
    [headImage sd_setImageWithURL:headUrl];
    [headImage addGestureRecognizer:tap];
    [backgroundImage addSubview:headImage];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.width * 0.2, self.view.height * 0.2, self.view.width * 0.2, self.view.height * 0.05)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.6;
    view.layer.cornerRadius = view.height / 3;
    view.clipsToBounds = YES;
    [backgroundImage addSubview:view];
    
    UILabel *viewNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height / 3)];
    viewNumber.text =[NSString stringWithFormat:@"%ld",_hotTopic.view];
    viewNumber.textAlignment = NSTextAlignmentCenter;
    viewNumber.font = [UIFont systemFontOfSize:12];
    viewNumber.textColor = [UIColor whiteColor];
    [view addSubview:viewNumber];
    
    UILabel *viewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, viewNumber.height, viewNumber.width, viewNumber.height)];
    viewLabel.textColor = [UIColor whiteColor];
    viewLabel.textAlignment = NSTextAlignmentCenter;
    viewLabel.text = @"浏览数";
    viewLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:viewLabel];
    
    UIView *subscribeView = [[UIView alloc] initWithFrame:CGRectMake(self.view.width * 0.6, self.view.height * 0.2, self.view.width * 0.2, self.view.height * 0.05)];
    subscribeView.backgroundColor = [UIColor blackColor];
    subscribeView.alpha = 0.6;
    subscribeView.layer.cornerRadius = subscribeView.height / 3;
    subscribeView.clipsToBounds = YES;
    [backgroundImage addSubview:subscribeView];
    
    UILabel *subscribeNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height / 3)];
    subscribeNumber.text =[NSString stringWithFormat:@"%ld",_hotTopic.subscribe];
    subscribeNumber.textAlignment = NSTextAlignmentCenter;
    subscribeNumber.font = [UIFont systemFontOfSize:12];
    subscribeNumber.textColor = [UIColor whiteColor];
    [subscribeView addSubview:subscribeNumber];
    
    UILabel *subscribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, viewNumber.height, viewNumber.width, viewNumber.height)];
    subscribeLabel.textColor = [UIColor whiteColor];
    subscribeLabel.textAlignment = NSTextAlignmentCenter;
    subscribeLabel.text = @"关注数";
    subscribeLabel.font = [UIFont systemFontOfSize:12];
    [subscribeView addSubview:subscribeLabel];

}
- (void)tapAction{
        UserViewController *userView = [[UserViewController alloc] init];
        userView.uid = _hotTopic.uid;
        [self.navigationController pushViewController:userView animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _albumArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:_collectionView]) {
        AlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.model = _albumArray[indexPath.item];
        return cell;
        
    }
    AlbumCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cardCellIdentifier forIndexPath:indexPath];
    cell.model = _albumArray[indexPath.item];
    return cell;
    
}

- (void)netWorking {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6B72B3B832A054648EB2B435216FF109CD" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/card/select_by_album?aid=%@&uid=189186&limit=10&queue=1",_hotTopic.aid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in [responseObject objectForKey:@"cards"]) {
            AlbumModel *model = [[AlbumModel alloc] initWithDic:dic];
            [_albumArray addObject:model];
        }
        _collectionView.size = CGSizeMake(_albumArray.count * self.view.width * 0.4 +( _albumArray.count + 2) * 12 , self.view.height * 0.55);
        _bigScrollView.contentSize  = CGSizeMake(self.view.width * 0.4 + _collectionView.width, 0);
        
        _bigCollectionView.size = CGSizeMake(_albumArray.count * (self.view.width - 10) + (_albumArray.count - 1) * 10, self.view.height - 10);
        _bigView.contentSize = CGSizeMake(5 + _bigCollectionView.width, 0);
        
        [_collectionView reloadData];
        [_bigCollectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)CreatScrollView {
    
    self.bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.height * 0.35, self.view.width, self.view.height * 0.55)];
    _bigScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_bigScrollView];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.width * 0.6, self.view.height * 0.55);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake((self.view.width * 0.4 ) / 2, 0, self.view.width , self.view.height * 0.55) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.scrollEnabled = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_bigScrollView addSubview:_collectionView];
    [_collectionView registerClass:[AlbumCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    AlbumCollectionViewCell *cell = (AlbumCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    _bigView.frame = CGRectMake(indexPath.item * self.view.width * 0.6 + self.view .width * 0.4 + ( indexPath.item) * 10 , self.view.height * 0.35, self.view.width * 0.6,self.view.height * 0.55) ;
    
    _bigView.contentOffset = CGPointMake(_bigView.width * indexPath.item, 0);
    [UIView animateWithDuration:1.0f animations:^{
        _bigScrollView.scrollEnabled = NO;
        _bigView.frame = CGRectMake(0, 5, self.view.width , self.view.height - 10);
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
