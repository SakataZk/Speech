//
//  ActiveInfoViewController.m
//  Talking
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "ActiveInfoViewController.h"
#import "ActivityModel.h"
#import "UIImageView+WebCache.h"
#import "CheckActivityViewController.h"

@interface ActiveInfoViewController ()

@end

@implementation ActiveInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    
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
    
    UIScrollView *bodyScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleLabel.height, self.view.width, self.view.height - titleLabel.height)];
    bodyScrollView.contentSize = CGSizeMake(self.view.width, self.view.height);
    bodyScrollView.bounces = NO;
    bodyScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bodyScrollView];
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:_model.bigPicture];
    [imageView sd_setImageWithURL:url];
    [bodyScrollView addSubview:imageView];

    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height * 0.91, self.view.width, self.view.height * 0.09)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.8f;
    [self.view addSubview:bottomView];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.77, bottomView.height)];
    bottomLabel.textColor = [UIColor whiteColor];
    bottomLabel.text = [NSString stringWithFormat:@"    #本期活动#%@",_model.name];
    [bottomView addSubview:bottomLabel];
    
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.frame = CGRectMake(self.view.width *0.77, bottomView.height /4 , self.view.width * 0.2, bottomView.height / 2);
    checkButton.layer.cornerRadius = 5;
    checkButton.clipsToBounds = YES;
    checkButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.9156 blue:0.0506 alpha:1.0];
    [checkButton setTitle:@"立即查看" forState:UIControlStateNormal];
    [checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bottomView addSubview:checkButton];
    [checkButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        CheckActivityViewController *checkActivityView = [[CheckActivityViewController alloc] init];
        checkActivityView.model = _model;
        [self.navigationController pushViewController:checkActivityView animated:YES];
    }];
    
    
    
    
    
    // Do any additional setup after loading the view.
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
