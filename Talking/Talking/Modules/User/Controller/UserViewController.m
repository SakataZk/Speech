//
//  UserViewController.m
//  Talking
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "UserViewController.h"
#import "WalletViewController.h"
#import "SettingViewController.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"
@interface UserViewController ()

@property (nonatomic, strong) id userInfo;

@property (nonatomic, strong) UIImageView *backgroungImage;

@property (nonatomic, strong) UILabel *nickNameLabel;

@property (nonatomic, strong) UIImageView *headImgeView;

@property (nonatomic, strong) UILabel *viewNumber;

@property (nonatomic, strong) UILabel *albumSubscribeTimesNumber;

@property (nonatomic, strong) UILabel *cardCountNumber;

@property (nonatomic, strong) UILabel *aboutMe;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    [self GetUserInfo];
    
    self.backgroungImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.53)];
    _backgroungImage.userInteractionEnabled = YES;
    
    [self.view addSubview:_backgroungImage];
    [self CreatBackgoudButton];
    [self CreatHeadView];
    [self CreatView];
    [self CreatAlbumsButton];
    [self GetAlbumsInfo];
    

    
}
- (void)CreatBackgoudButton {
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.frame = CGRectMake(self.view.width * 0.055, self.view.height * 0.047, self.view.width * 0.06, self.view.height * 0.04);
    [returnButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    returnButton.backgroundColor = [UIColor clearColor];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [_backgroungImage addSubview:returnButton];
    
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, returnButton.y, self.view.width * 0.4, returnButton.height)];
    _nickNameLabel.centerX = self.view.centerX;
    _nickNameLabel.backgroundColor = [UIColor clearColor];
    _nickNameLabel.text = @"";
    _nickNameLabel.textAlignment = NSTextAlignmentCenter;
    _nickNameLabel.textColor = [UIColor whiteColor];
    _nickNameLabel.font = [UIFont systemFontOfSize:22];
    [_backgroungImage addSubview:_nickNameLabel];
    
    UIButton *walletButton = [UIButton buttonWithType:UIButtonTypeCustom];
    walletButton.frame = CGRectMake(self.view.width * 0.78, _nickNameLabel.y, returnButton.width / 3 * 4 , returnButton.height);
    [walletButton setImage:[UIImage imageNamed:@"wallet"] forState:UIControlStateNormal];
    [_backgroungImage addSubview:walletButton];
    [walletButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        WalletViewController *wallectVC = [[WalletViewController alloc] init];
        [self.navigationController pushViewController:wallectVC animated:YES];
    }];
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame = CGRectMake(self.view.width * 0.9, walletButton.y, returnButton.width, returnButton.height);
    [settingButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [_backgroungImage addSubview:settingButton];
    [settingButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        SettingViewController *settingVC = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }];
    
}

- (void)CreatHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height * 0.1, self.view.width * 0.185, self.view.width * 0.185)];
    headView.backgroundColor = [UIColor whiteColor];
    headView.centerX = self.view.centerX;
    headView.layer.cornerRadius = self.view.width * 0.185 / 2;
    headView.clipsToBounds = YES;
    [self.view addSubview:headView];
    
    self.headImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.width * 0.17, self.view.width * 0.17)];
    _headImgeView.center = headView.center;
    _headImgeView.layer.cornerRadius = self.view.width * 0.17 / 2;
    _headImgeView.clipsToBounds = YES;
    [self.view addSubview:_headImgeView];


}

- (void)CreatView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height * 0.23, self.view.width,self.view.width * 0.11)];
    [self.view addSubview:view];
    
    UILabel *viewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.height / 2, ( self.view.width - 4 ) / 3, view.height / 2)];
    viewLabel.text = @"浏览数";
    viewLabel.textColor = [UIColor whiteColor];
    viewLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:viewLabel];
    
    self.viewNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ( self.view.width - 4 ) / 3, view.height / 2)];
    _viewNumber.text = @"";
    _viewNumber.textColor = [UIColor whiteColor];
    _viewNumber.textAlignment = NSTextAlignmentCenter;
    [view addSubview:_viewNumber];
    
    UILabel *firstRule = [[UILabel alloc] initWithFrame:CGRectMake(_viewNumber.width, 0, 2, view.height)];
    firstRule.backgroundColor = [UIColor whiteColor];
    [view addSubview:firstRule];
    
    UILabel *albumSubscribeTimes = [[UILabel alloc] initWithFrame:CGRectMake(firstRule.x + firstRule.width, viewLabel.y, viewLabel.width, viewLabel.height)];
    albumSubscribeTimes.text = @"关注数";
    albumSubscribeTimes.textColor = [UIColor whiteColor];
    albumSubscribeTimes.textAlignment = NSTextAlignmentCenter;
    [view addSubview:albumSubscribeTimes];
    
    self.albumSubscribeTimesNumber = [[UILabel alloc] initWithFrame:CGRectMake(albumSubscribeTimes.x, 0, albumSubscribeTimes.width, albumSubscribeTimes.height)];
    _albumSubscribeTimesNumber.text = @"";
    _albumSubscribeTimesNumber.textAlignment = NSTextAlignmentCenter;
    _albumSubscribeTimesNumber.textColor = [UIColor whiteColor];
    [view addSubview:_albumSubscribeTimesNumber];
    
    UILabel *secondRile = [[UILabel alloc] initWithFrame:CGRectMake(_albumSubscribeTimesNumber.width + _albumSubscribeTimesNumber.x, 0, 2, view.height)];
    secondRile.backgroundColor = [UIColor whiteColor];
    [view addSubview:secondRile];
    
    UILabel *cardCount = [[UILabel alloc] initWithFrame:CGRectMake(secondRile.x + secondRile.width, albumSubscribeTimes.y, _albumSubscribeTimesNumber.width, _albumSubscribeTimesNumber.height)];
    cardCount.text = @"发布数";
    cardCount.textColor = [UIColor whiteColor];
    cardCount.textAlignment = NSTextAlignmentCenter;
    [view addSubview:cardCount];
    
    self.cardCountNumber = [[UILabel alloc] initWithFrame:CGRectMake(cardCount.x , 0, cardCount.width, cardCount.height)];
    _cardCountNumber.text = @"";
    _cardCountNumber.textAlignment = NSTextAlignmentCenter;
    _cardCountNumber.textColor = [UIColor whiteColor];
    [view addSubview:_cardCountNumber];

    self.aboutMe = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width * 0.04, view.height + view.y + _cardCountNumber.height, self.view.width * 0.92, _backgroungImage.height - view.y - view.height - _cardCountNumber.height * 2)];
    _aboutMe.textColor = [UIColor whiteColor];
    _aboutMe.numberOfLines  = 0;
    [_backgroungImage addSubview:_aboutMe];

}

- (void)GetUserInfo {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/profile/query_profile?uid=%@",_uid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        UserModel *model = [[UserModel alloc] initWithDic:[responseObject objectForKey:@"profile"]];
        
        NSURL *url = [NSURL URLWithString:model.coverPicture];
        [_backgroungImage sd_setImageWithURL:url];
        
        _nickNameLabel.text = model.name;
        
        NSURL *headUrl = [NSURL URLWithString:model.smallPicture];
        [_headImgeView sd_setImageWithURL:headUrl];
        
        _viewNumber.text = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"cardViewTimes"]];
        
        _albumSubscribeTimesNumber.text = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"albumSubscribeTimes"]];
        
        _cardCountNumber.text = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"cardCount"]];
        
        _aboutMe.text = model.aboutMe;
        [_aboutMe sizeToFit];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)CreatAlbumsButton {
    
    

    
    UIButton *albumsButton = [UIButton buttonWithType: UIButtonTypeCustom];
    albumsButton.frame = CGRectMake(0, _backgroungImage.height, self.view.width / 3, _nickNameLabel.height);
    [albumsButton setTitle:@"言集" forState:UIControlStateNormal];
    [albumsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:albumsButton];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, albumsButton.y + albumsButton.height, albumsButton.width, 2)];
    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
    
    [albumsButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        label.frame = CGRectMake(0, albumsButton.y + albumsButton.height, albumsButton.width, 2);
        [self GetAlbumsInfo];
    }];

    
    UIButton *attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionButton.frame = CGRectMake(albumsButton.width, albumsButton.y, albumsButton.width, albumsButton.height);
    [attentionButton setTitle:@"关注" forState:UIControlStateNormal];
    [attentionButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:attentionButton];
    [attentionButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        label.frame = CGRectMake(albumsButton.width, albumsButton.y + albumsButton.height, albumsButton.width, 2);
        [self GetAttention];
    }];


    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(attentionButton.x + attentionButton.width, attentionButton.y, attentionButton.width, attentionButton.height);
    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:collectButton];
     
    
    
}

- (void)GetAlbumsInfo {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/album/user_albums?uid=%@",_uid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];


}
- (void)GetAttention {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/subscribe/get_albums_by_uid?uid=%@",_uid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        
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
