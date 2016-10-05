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



@interface TalkingHomeViewController ()
<SGTopTitleViewDelegate,
UIScrollViewDelegate
>
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) BOOL isSelect;

@end

@implementation TalkingHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    [self addChildViewController:oneVC];
    TalkingViewController *twoVC = [[TalkingViewController alloc] init];
    [self addChildViewController:twoVC];
    TopicViewController *threeVC = [[TopicViewController alloc] init];
    [self addChildViewController:threeVC];
    ActivityViewController *fourVC = [[ActivityViewController alloc] init];
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
    userInfoButton.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar addSubview:userInfoButton];
    [userInfoButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        UserViewController *userView = [[UserViewController alloc] init];
        userView.uid = @189186;
        [self.navigationController pushViewController:userView animated:YES];
    }];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(self.view.width - userInfoButton.width, 0, userInfoButton.width, userInfoButton.height);
    searchButton.backgroundColor = [UIColor whiteColor];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:searchButton];
    [searchButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        SearchViewController *searchView = [[SearchViewController alloc] init];
        [self.navigationController pushViewController:searchView animated:YES];
    }];
}

- (void)creatFloatButton {
    
   
    UIButton *floatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    floatButton.frame = CGRectMake(self.view.width * 0.07, self.view.height * 0.8, self.view.width * 0.1, self.view.width * 0.1);
    floatButton.backgroundColor = [UIColor clearColor];
    [floatButton setImage:[UIImage imageNamed:@"floatButton"] forState:UIControlStateNormal];
    [self.view addSubview:floatButton];
    
    
    UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(floatButton.x, floatButton.y, floatButton.width * 3 / 2, floatButton.width * 3 / 2)];
    cardView .backgroundColor = [UIColor darkGrayColor];
    cardView.hidden = YES;
    cardView.layer.cornerRadius =  floatButton.width * 3 / 4;
    cardView.clipsToBounds = YES;
    cardView.layer.borderColor = [UIColor whiteColor].CGColor;
    cardView.layer.borderWidth = 2;
    [self.view addSubview:cardView];
    
    UIButton *cardButton = [[UIButton alloc] initWithFrame:CGRectMake(cardView.width / 4, 0, cardView.width / 2, cardView.width / 2)];
    [cardButton setImage:[UIImage imageNamed:@"card"] forState:UIControlStateNormal];
    [cardView addSubview:cardButton];
    
    UILabel *cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cardButton.height, cardView.width, cardView.width / 3)];
    cardLabel.text = @"写卡片";
    cardLabel.textAlignment = NSTextAlignmentCenter;
    cardLabel.textColor = [UIColor whiteColor];
    cardLabel.font = [UIFont systemFontOfSize:12];
    [cardView addSubview:cardLabel];


    UIView *articleView = [[UIView alloc] initWithFrame:CGRectMake(cardView.x , cardView.y , cardView.width, cardView.height)];
    articleView.backgroundColor = [UIColor darkGrayColor];
    articleView.layer.cornerRadius =  floatButton.width * 3 / 4;
    articleView.clipsToBounds = YES;
    articleView.layer.borderColor = [UIColor whiteColor].CGColor;
    articleView.layer.borderWidth = 2;
    articleView.hidden = YES;
    [self.view addSubview:articleView];
    
    UIButton *articleButton = [[UIButton alloc] initWithFrame:CGRectMake(articleView.width / 4, 0, articleView.width / 2, articleView.width / 2)];
    [articleButton setImage:[UIImage imageNamed:@"article"] forState:UIControlStateNormal];
    [articleView addSubview:articleButton];
    
    UILabel *articleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, articleButton.height, articleView.width, articleView.width / 3)];
    articleLabel.text = @"写长文";
    articleLabel.textAlignment = NSTextAlignmentCenter;
    articleLabel.textColor = [UIColor whiteColor];
    articleLabel.font = [UIFont systemFontOfSize:12];
    [articleView addSubview:articleLabel];
    
    
    UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(articleView.x, articleView.y, articleView.width, articleView.height)];
    messageView.backgroundColor = [UIColor darkGrayColor];
    messageView.layer.cornerRadius =  floatButton.width * 3 / 4;
    messageView.clipsToBounds = YES;
    messageView.layer.borderColor = [UIColor whiteColor].CGColor;
    messageView.layer.borderWidth = 2;
    messageView.hidden = YES;
    [self.view addSubview:messageView];
    
    UIButton *messageButton = [[UIButton alloc] initWithFrame:CGRectMake(messageView.width / 4, 0, messageView.width / 2, messageView.width / 2)];
    [messageButton setImage:[UIImage imageNamed:@"information"] forState:UIControlStateNormal];
    [messageView addSubview:messageButton];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, messageButton.height, messageView.width, messageView.width / 3)];
    messageLabel.text = @"个人信息";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.font = [UIFont systemFontOfSize:12];
    [messageView addSubview:messageLabel];
    
    [messageButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        UserViewController *userView = [[UserViewController alloc] init];
        userView.uid = @189186;
        [self.navigationController pushViewController:userView animated:YES];
    }];
    
    
   
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(messageView.x, messageView.y ,messageView.width, messageView.height)];
    searchView.backgroundColor = [UIColor darkGrayColor];
    searchView.layer.cornerRadius =  floatButton.width * 3 / 4;
    searchView.clipsToBounds = YES;
    searchView.layer.borderColor = [UIColor whiteColor].CGColor;
    searchView.layer.borderWidth = 2;
    searchView.hidden = YES;
    [self.view addSubview:searchView];
    
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(searchView.width / 4, 0, searchView.width / 2, searchView.width / 2)];
    [searchButton setImage:[UIImage imageNamed:@"white search"] forState:UIControlStateNormal];
    [searchView addSubview:searchButton];
    
    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, searchButton.height, searchView.width, searchView.width / 3)];
    searchLabel.text = @"搜索";
    searchLabel.textAlignment = NSTextAlignmentCenter;
    searchLabel.textColor = [UIColor whiteColor];
    searchLabel.font = [UIFont systemFontOfSize:12];
    [searchView addSubview:searchLabel];
    [searchButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        SearchViewController *searchView = [[SearchViewController alloc] init];
        [self.navigationController pushViewController:searchView animated:YES];
    }];
    
    
    
    UIView *mailboxView = [[UIView alloc] initWithFrame:CGRectMake(searchView.x , searchView.y, searchView.width, searchView.height)];
    mailboxView.backgroundColor = [UIColor darkGrayColor];
    mailboxView.layer.cornerRadius =  floatButton.width * 3 / 4;
    mailboxView.clipsToBounds = YES;
    mailboxView.layer.borderColor = [UIColor whiteColor].CGColor;
    mailboxView.layer.borderWidth = 2;
    mailboxView.hidden = YES;
    [self.view addSubview:mailboxView];
    
    
    UIButton *mailboxButton = [[UIButton alloc] initWithFrame:CGRectMake(mailboxView.width / 4, 0, mailboxView.width / 2, mailboxView.width / 2)];
    [mailboxButton setImage:[UIImage imageNamed:@"mailbox"] forState:UIControlStateNormal];
    [mailboxView addSubview:mailboxButton];
    
    UILabel *mailboxLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, mailboxButton.height, mailboxView.width, mailboxView.width / 3)];
    mailboxLabel.text = @"信箱";
    mailboxLabel.textAlignment = NSTextAlignmentCenter;
    mailboxLabel.textColor = [UIColor whiteColor];
    mailboxLabel.font = [UIFont systemFontOfSize:12];
    [mailboxView addSubview:mailboxLabel];
    
    UIView *newsView = [[UIView alloc] initWithFrame:CGRectMake(mailboxView.x , mailboxView.y, mailboxView.width, mailboxView.height)];
    newsView.backgroundColor = [UIColor darkGrayColor];
    newsView.layer.cornerRadius =  floatButton.width * 3 / 4;
    newsView.clipsToBounds = YES;
    newsView.layer.borderColor = [UIColor whiteColor].CGColor;
    newsView.layer.borderWidth = 2;
    newsView.hidden = YES;
    [self.view addSubview:newsView];
    
    UIButton *newsButton = [[UIButton alloc] initWithFrame:CGRectMake(newsView.width / 4, 0, newsView.width / 2, newsView.width / 2)];
    [newsButton setImage:[UIImage imageNamed:@"messenge"] forState:UIControlStateNormal];
    [newsView addSubview:newsButton];
    
    UILabel *newsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, newsButton.height, newsView.width, newsView.width / 3)];
    newsLabel.text = @"消息";
    newsLabel.textAlignment = NSTextAlignmentCenter;
    newsLabel.textColor = [UIColor whiteColor];
    newsLabel.font = [UIFont systemFontOfSize:12];
    [newsView addSubview:newsLabel];
    self.isSelect = NO;
   
    [floatButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        
        if (_isSelect == NO) {
            [UIView animateWithDuration:0.5f animations:^{
                _isSelect = YES;
                cardView.hidden = NO;
                articleView.hidden = NO;
                messageView.hidden = NO;
                searchView.hidden = NO;
                mailboxView.hidden = NO;
                newsView.hidden = NO;
                cardView.frame = CGRectMake(floatButton.x, floatButton.y - self.view.height * 0.4, floatButton.width * 3 / 2, floatButton.width * 3 / 2);
                articleView.frame = CGRectMake(cardView.x + self.view.height * 0.4 / 6, cardView.y + self.view .height * 0.4 / 6, cardView.width, cardView.height);
                messageView.frame = CGRectMake(articleView.x + self.view.height * 0.4 / 6, articleView.y + self.view.height * 0.4 / 6, articleView.width, articleView.height);
                searchView.frame = CGRectMake(messageView.x + self.view.height * 0.4 / 6, messageView.y + self.view.height * 0.4 / 6, messageView.width, messageView.height);
                mailboxView.frame = CGRectMake(searchView.x + self.view.height * 0.4 / 6, searchView.y + self.view.height * 0.4 / 6, searchView.width, searchView.height);
                newsView.frame = CGRectMake(mailboxView.x + self.view.height * 0.4 / 6, mailboxView.y + self.view.height * 0.4 / 6, mailboxView.width, mailboxView.height);
            }];

        } else {
        
        [UIView animateWithDuration:0.5f animations:^{
            _isSelect = NO;
            cardView.center = floatButton.center;
            articleView.center = floatButton.center;
            messageView.center = floatButton.center;
            searchView.center = floatButton.center;
            mailboxView.center = floatButton.center;
            newsView.center = floatButton.center;
        } completion:^(BOOL finished) {
            cardView.hidden = YES;
            articleView.hidden = YES;
            messageView.hidden = YES;
            searchView.hidden = YES;
            mailboxView.hidden = YES;
            newsView .hidden = YES;
        }];
       
        }
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
