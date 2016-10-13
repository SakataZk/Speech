//
//  longTextViewController.m
//  Talking
//
//  Created by dllo on 16/10/11.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "longTextViewController.h"

@interface longTextViewController ()
<
UITextViewDelegate
>
@end

@implementation longTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [self creatHeadView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.width * 0.17, self.view.height * 0.2, self.view.width * 0.66, self.view.height * 0.7)];
    [textView becomeFirstResponder];
    textView.delegate = self;
    [self.view addSubview:textView];
    
    
    // Do any additional setup after loading the view.
}
- (void)textViewDidChange:(UITextView *)textView {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;    //行间距
    paragraphStyle.maximumLineHeight = 20;   /**最大行高*/
    paragraphStyle.firstLineHeadIndent = 15.f;    /**首行缩进宽度*/
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}


- (void)creatHeadView {
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setTitle:@"取消" forState:UIControlStateNormal];
    [returnButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    returnButton.frame = CGRectMake(self.view.width * 0.04, self.view.height * 0.057, self.view.width * 0.1, self.view.width * 0.05);
    [self.view addSubview:returnButton];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.2, self.view.width * 0.04)];
    titleLabel.centerX = self.view.centerX;
    titleLabel.centerY = returnButton.centerY;
    titleLabel.text = @"编写内容";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleLabel];
    
    UIButton *nextTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextTypeButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextTypeButton.frame = CGRectMake(self.view.width * 0.8 , 0, self.view.width * 0.15, self.view.width * 0.05);
    nextTypeButton.centerY = returnButton.centerY;
    [nextTypeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:nextTypeButton];
    
    UILabel *cutLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height * 0.1, self.view.width, 1)];
    cutLineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:cutLineLabel];
    
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
