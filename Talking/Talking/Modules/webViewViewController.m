//
//  webViewViewController.m
//  Talking
//
//  Created by dllo on 16/10/12.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "webViewViewController.h"

@interface webViewViewController ()

@end

@implementation webViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.08)];
    titleLabel.userInteractionEnabled = YES;
    titleLabel.text = _text;
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

    
    
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, titleLabel.height, SCREEN_WIDTH, SCREEN_HEIGHT * 0.92)];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_activitying]];
    [self.view addSubview:webView];
    [webView loadRequest:request];
    [webView setDelegate:self];
    
    
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
