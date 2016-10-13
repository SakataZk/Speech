//
//  guideViewController.m
//  Talking
//
//  Created by dllo on 16/10/13.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "guideViewController.h"
#import "LoginViewController.h"
@interface guideViewController ()
<
UIScrollViewDelegate
>
{
    //  页码控制器
    UIPageControl *pageController;
    //  判断是否是第一次进入应用
    BOOL flag;
}
@end

@implementation guideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    for (int i = 0; i <= 2; i++) {
        NSString *imageName = [NSString stringWithFormat:@"0%d.jpg",i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        //  在最后一页设置按钮
        if (2 == i) {
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT * 7 / 8, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16);
            [button setTitle:@"点击进入" forState:UIControlStateNormal];
            //  设置button圆角
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            //  设置button边框颜色
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    //  隐藏滚动条
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    
    //  pageController
    pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT * 15 / 16, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16)];
    pageController.numberOfPages = 3;
    pageController.pageIndicatorTintColor = [UIColor colorWithRed:0.3592 green:0.3279 blue:0.3776 alpha:1.0];
    pageController.currentPageIndicatorTintColor = [UIColor colorWithRed:0.7963 green:0.7391 blue:1.0 alpha:1.0];
    [self.view addSubview:pageController];
    // Do any additional setup after loading the view.
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageController.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
    
}
- (void)buttonAction:(UIButton *)button {
    flag = YES;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    //  保存用户数据
    [userDef setBool:flag forKey:@"notFirst"];
    [userDef synchronize];
    //  切换到根视图控制器
    LoginViewController *loginView = [[LoginViewController alloc] init];
    UINavigationController *loginNa = [[UINavigationController alloc] initWithRootViewController:loginView];
    self.view.window.rootViewController = loginNa;
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
