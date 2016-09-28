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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, titleLabel.height, self.view.width, self.view.height - titleLabel.height)];
    imageView.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:_model.bigPicture];
    [imageView sd_setImageWithURL:url];
    [self.view addSubview:imageView];
    [titleLabel addSubview:returnButton];

    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height * 0.91, self.view.width, self.view.height * 0.09)];
    bottomLabel.backgroundColor = [UIColor blackColor];
    bottomLabel.alpha = 0.8f;
    bottomLabel.textColor = [UIColor whiteColor];
    bottomLabel.text = [NSString stringWithFormat:@"    #本期活动#%@",_model.name];
    [self.view addSubview:bottomLabel];
    
//    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    checkButton.frame = CGRectMake(self.view.width *0.77, 0, <#CGFloat width#>, <#CGFloat height#>)
//    
//    [checkButton setTitle:@"立即查看" forState:UIControlStateNormal];
    
    
    
    
    
    
    
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
