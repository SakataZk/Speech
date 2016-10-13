//
//  TalkingHomeViewController.m
//  Talking
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "TalkingHomeViewController.h"
#import "SGTopTitleView.h"
#import "HomeViewController.h"
#import "TalkingViewController.h"
#import "TopicViewController.h"
#import "ActivityViewController.h"
#import "UserViewController.h"
#import "SearchViewController.h"
#import "CardViewController.h"
#import "NewsViewController.h"
#import "mailboxViewController.h"
#import "longTextViewController.h"




@interface TalkingHomeViewController ()
<SGTopTitleViewDelegate,
UIScrollViewDelegate
>
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) UIButton *floatButton;

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UIView *articleView;
@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIView *mailboxView;
@property (nonatomic, strong) UIView *newsView;
@end

@implementation TalkingHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;

}
- (void)viewDidDisappear:(BOOL)animated {
    [self floatButtonPickUp];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton =YES;
    [self creatButton];
    [self creatView];
    [self creatFloatButton];
    // Do any additional setup after loading the view.
}
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index{
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    [self showVc:index];
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    CGFloat offsetX = index * self.view.frame.size.width;
    UIViewController *VC = self.childViewControllers[index];
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (VC.isViewLoaded) return;
    [self.mainScrollView addSubview:VC.view];
    VC.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self showVc:index];
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    [self.topTitleView staticTitleLabelSelecteded:selLabel];
    
}

- (void)creatView {
    
    HomeViewController *oneVC = [[HomeViewController alloc] init];
    oneVC.token = _token;
    oneVC.uid = _uid;
    [self addChildViewController:oneVC];
    TalkingViewController *twoVC = [[TalkingViewController alloc] init];
    twoVC.uid = _uid;
    twoVC.token = _token;
    [self addChildViewController:twoVC];
    TopicViewController *threeVC = [[TopicViewController alloc] init];
    threeVC.uid = _uid;
    threeVC.token = _token;
    [self addChildViewController:threeVC];
    ActivityViewController *fourVC = [[ActivityViewController alloc] init];
    fourVC.uid = _uid;
    fourVC.token = _token;
    [self addChildViewController:fourVC];
    
    self.titles = @[@"首页", @"人言", @"主题", @"活动"];
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(self.view.width * 0.2, 0, self.view.frame.size.width * 0.6, self.navigationController.navigationBar.height)];
    _topTitleView.scrollTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.showsTitleBackgroundIndicatorStyle = NO;
    _topTitleView.delegate_SG = self;
    [self.navigationController.navigationBar addSubview:_topTitleView];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    _mainScrollView.scrollEnabled = NO;
    
    [self.view addSubview:_mainScrollView];
    
    [self.mainScrollView addSubview:oneVC.view];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];



}

- (void)creatButton {
    
    UIButton *userInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userInfoButton.frame = CGRectMake(0, 0, self.navigationController.navigationBar.height, self.navigationController.navigationBar.height);
    
    userInfoButton.backgroundColor = [UIColor lightGrayColor];
    NSURL *url = [NSURL URLWithString:_picture];
    UIImage *imge = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    [userInfoButton setImage:imge forState:UIControlStateNormal];
    userInfoButton.layer.cornerRadius = self.navigationController.navigationBar.height / 2;
    userInfoButton.clipsToBounds = YES;
    [self.navigationController.navigationBar addSubview:userInfoButton];
    
    [userInfoButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        UserViewController *userView = [[UserViewController alloc] init];
        userView.headId = _uid;
        userView.uid = _uid;
        userView.token = _token;
        [self.navigationController pushViewController:userView animated:YES];
    }];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(self.view.width - userInfoButton.width, 0, userInfoButton.width, userInfoButton.height);
    searchButton.backgroundColor = [UIColor whiteColor];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:searchButton];
    
    [searchButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        SearchViewController *searchView = [[SearchViewController alloc] init];
        searchView.uid = _uid;
        searchView.token  = _token;
        [self.navigationController pushViewController:searchView animated:YES];
    }];
}

- (void)creatFloatButton {
    
   
    self.floatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _floatButton.frame = CGRectMake(self.view.width * 0.07, self.view.height * 0.8, self.view.width * 0.1, self.view.width * 0.1);
    _floatButton.backgroundColor = [UIColor clearColor];
    [_floatButton setImage:[UIImage imageNamed:@"floatButton"] forState:UIControlStateNormal];
    [self.view addSubview:_floatButton];
    
    
    self.cardView = [[UIView alloc] initWithFrame:CGRectMake(_floatButton.x, _floatButton.y, _floatButton.width * 3 / 2, _floatButton.width * 3 / 2)];
    _cardView .backgroundColor = [UIColor darkGrayColor];
    _cardView.hidden = YES;
    _cardView.layer.cornerRadius =  _floatButton.width * 3 / 4;
    _cardView.clipsToBounds = YES;
    _cardView.layer.borderColor = [UIColor whiteColor].CGColor;
    _cardView.layer.borderWidth = 2;
    [self.view addSubview:_cardView];
    
    UIButton *cardButton = [[UIButton alloc] initWithFrame:CGRectMake(_cardView.width / 4, _cardView.height / 4, _cardView.width / 2, _cardView.width / 2)];
    [cardButton setImage:[UIImage imageNamed:@"card"] forState:UIControlStateNormal];
    [_cardView addSubview:cardButton];
    
    [cardButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
    CardViewController *cardViewController = [[CardViewController alloc] init];
        
    [self.navigationController pushViewController:cardViewController animated:YES];

}];

    self.articleView = [[UIView alloc] initWithFrame:CGRectMake(_cardView.x , _cardView.y , _cardView.width, _cardView.height)];
    _articleView.backgroundColor = [UIColor darkGrayColor];
    _articleView.layer.cornerRadius =  _floatButton.width * 3 / 4;
    _articleView.clipsToBounds = YES;
    _articleView.layer.borderColor = [UIColor whiteColor].CGColor;
    _articleView.layer.borderWidth = 2;
    _articleView.hidden = YES;
    [self.view addSubview:_articleView];
    
    UIButton *articleButton = [[UIButton alloc] initWithFrame:CGRectMake(_articleView.width / 4, _articleView.height / 4, _articleView.width / 2, _articleView.width / 2)];
    [articleButton setImage:[UIImage imageNamed:@"article"] forState:UIControlStateNormal];
    [_articleView addSubview:articleButton];
    [articleButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        longTextViewController *longTextView = [[longTextViewController alloc] init];
        [self.navigationController pushViewController:longTextView animated:YES];
    }];

    
    
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(_articleView.x, _articleView.y, _articleView.width, _articleView.height)];
    _messageView.backgroundColor = [UIColor darkGrayColor];
    _messageView.layer.cornerRadius =  _floatButton.width * 3 / 4;
    _messageView.clipsToBounds = YES;
    _messageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _messageView.layer.borderWidth = 2;
    _messageView.hidden = YES;
    [self.view addSubview:_messageView];
    
    UIButton *messageButton = [[UIButton alloc] initWithFrame:CGRectMake(_messageView.width / 4, _messageView.height / 4, _messageView.width / 2, _messageView.width / 2)];
    [messageButton setImage:[UIImage imageNamed:@"information"] forState:UIControlStateNormal];
    [_messageView addSubview:messageButton];
    

    
    [messageButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        UserViewController *userView = [[UserViewController alloc] init];
        userView.headId = _uid;
        userView.token = _token;
        userView.uid = _uid;
        [self.navigationController pushViewController:userView animated:YES];
    }];
    
    
   
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(_messageView.x, _messageView.y ,_messageView.width, _messageView.height)];
    _searchView.backgroundColor = [UIColor darkGrayColor];
    _searchView.layer.cornerRadius =  _floatButton.width * 3 / 4;
    _searchView.clipsToBounds = YES;
    _searchView.layer.borderColor = [UIColor whiteColor].CGColor;
    _searchView.layer.borderWidth = 2;
    _searchView.hidden = YES;
    [self.view addSubview:_searchView];
    
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(_searchView.width / 4, _searchView.height / 4, _searchView.width / 2, _searchView.width / 2)];
    [searchButton setImage:[UIImage imageNamed:@"white search"] forState:UIControlStateNormal];
    [_searchView addSubview:searchButton];
    

    
    
    [searchButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        SearchViewController *searchView = [[SearchViewController alloc] init];
        searchView.uid = _uid;
        searchView.token = _token;
        
        [self.navigationController pushViewController:searchView animated:YES];
    }];
    
    
    
    self.mailboxView = [[UIView alloc] initWithFrame:CGRectMake(_searchView.x , _searchView.y, _searchView.width, _searchView.height)];
    _mailboxView.backgroundColor = [UIColor darkGrayColor];
    _mailboxView.layer.cornerRadius =  _floatButton.width * 3 / 4;
    _mailboxView.clipsToBounds = YES;
    _mailboxView.layer.borderColor = [UIColor whiteColor].CGColor;
    _mailboxView.layer.borderWidth = 2;
    _mailboxView.hidden = YES;
    [self.view addSubview:_mailboxView];
    
    
    UIButton *mailboxButton = [[UIButton alloc] initWithFrame:CGRectMake(_mailboxView.width / 4, _mailboxView.height / 4, _mailboxView.width / 2, _mailboxView.width / 2)];
    [mailboxButton setImage:[UIImage imageNamed:@"mailbox"] forState:UIControlStateNormal];
    [_mailboxView addSubview:mailboxButton];
    
    [mailboxButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        mailboxViewController *mailboxView = [[mailboxViewController alloc] init];
        [self.navigationController pushViewController:mailboxView animated:YES];
    }];

    
    self.newsView = [[UIView alloc] initWithFrame:CGRectMake(_mailboxView.x , _mailboxView.y, _mailboxView.width, _mailboxView.height)];
    _newsView.backgroundColor = [UIColor darkGrayColor];
    _newsView.layer.cornerRadius =  _floatButton.width * 3 / 4;
    _newsView.clipsToBounds = YES;
    _newsView.layer.borderColor = [UIColor whiteColor].CGColor;
    _newsView.layer.borderWidth = 2;
    _newsView.hidden = YES;
    [self.view addSubview:_newsView];
    
    UIButton *newsButton = [[UIButton alloc] initWithFrame:CGRectMake(_newsView.width / 4, _newsView.height / 4, _newsView.width / 2, _newsView.width / 2)];
    [newsButton setImage:[UIImage imageNamed:@"messenge"] forState:UIControlStateNormal];
    [_newsView addSubview:newsButton];
    

    
   [newsButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
       NewsViewController *newsView = [[NewsViewController alloc] init];
       newsView.uid = _uid;
       newsView.token = _token;
       [self.navigationController pushViewController:newsView animated:YES];
   }];
    
    
    self.isSelect = NO;
    [_floatButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (_isSelect == NO) {
            [self floatButtonAnimation];
        } else {
            [self floatButtonPickUp];
        }
        }];

}

- (void)floatButtonAnimation {

    [UIView animateWithDuration:0.2f animations:^{
        _isSelect = YES;
        _cardView.hidden = NO;
        _articleView.hidden = NO;
        _messageView.hidden = NO;
        _searchView.hidden = NO;
        _mailboxView.hidden = NO;
        _newsView.hidden = NO;
        CGFloat angle = - M_PI / 11;
        CGFloat distence = _floatButton.y - self.view.height * 0.4;
        _cardView.center = CGPointMake(cos(angle * 0) * distence, _floatButton.centerY + sin(angle * 0) * distence);
        _articleView.center = CGPointMake(cos(angle * 1) *distence, _floatButton.centerY + sin(angle * 1) *distence);
        _messageView.center = CGPointMake(cos(angle * 2) * distence, _floatButton.centerY + sin(angle * 2) * distence);
        _searchView.center = CGPointMake(cos(angle * 3) *distence, _floatButton.centerY + sin(angle * 3) * distence);
        _mailboxView.center = CGPointMake(cos(angle * 4) *distence, _floatButton.centerY + sin(angle * 4) * distence);
        _newsView.center = CGPointMake(cos(angle * 5) *distence, _floatButton.centerY + sin(angle * 5) * distence);
    }];
    




}

- (void)floatButtonPickUp {
    [UIView animateWithDuration:0.2f animations:^{
        _isSelect = NO;
        _cardView.center = _floatButton.center;
        _articleView.center = _floatButton.center;
        _messageView.center = _floatButton.center;
        _searchView.center = _floatButton.center;
        _mailboxView.center = _floatButton.center;
        _newsView.center = _floatButton.center;
    } completion:^(BOOL finished) {
        _cardView.hidden = YES;
        _articleView.hidden = YES;
        _messageView.hidden = YES;
        _searchView.hidden = YES;
        _mailboxView.hidden = YES;
        _newsView .hidden = YES;
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
