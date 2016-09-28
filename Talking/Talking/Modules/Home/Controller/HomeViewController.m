//
//  HomeViewController.m
//  Talking
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "HomeViewController.h"
#import "SGTopTitleView.h"
#import "HotTopicViewController.h"
#import "EverydayViewController.h"

@interface HomeViewController ()<SGTopTitleViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) HotTopicViewController *hotTopicVC;

@end
@implementation HomeViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.hotTopicVC = [[HotTopicViewController alloc] init];
    [self addChildViewController:_hotTopicVC];
    EverydayViewController *twoVC = [[EverydayViewController alloc] init];
    [self addChildViewController:twoVC];

    
    self.titles = @[@"热门言集", @"每日精选"];
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.height * 0.07)];
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.isHiddenIndicator = YES;
    _topTitleView.delegate_SG = self;
    [self.view addSubview:_topTitleView];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, _topTitleView.height + 5, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    [self.mainScrollView addSubview:_hotTopicVC.view];
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
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

@end
