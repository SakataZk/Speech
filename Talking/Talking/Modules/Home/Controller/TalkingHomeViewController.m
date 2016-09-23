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



@interface TalkingHomeViewController ()<SGTopTitleViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation TalkingHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *userInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userInfoButton.frame = CGRectMake(0, 0, self.navigationController.navigationBar.height, self.navigationController.navigationBar.height);
    userInfoButton.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar addSubview:userInfoButton];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(self.view.width - userInfoButton.width, 0, userInfoButton.width, userInfoButton.height);
    searchButton.backgroundColor = [UIColor whiteColor];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    
    [self.navigationController.navigationBar addSubview:searchButton];
    self.automaticallyAdjustsScrollViewInsets = NO;
    

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
