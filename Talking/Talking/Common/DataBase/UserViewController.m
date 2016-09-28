//
//  UserViewController.m
//  Talking
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.frame = CGRectMake(self.view.width * 0.055, self.view.height * 0.047, self.view.width * 0.055, self.view.height * 0.047);
    [returnButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    returnButton.backgroundColor = [UIColor redColor];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:returnButton];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}
- (void)GetUserInfo {





    
    
    
    
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
