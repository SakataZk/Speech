//
//  LoginViewController.m
//  Talking
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+EAMD5.h"
#import "model.h"

@interface LoginViewController ()

@property (nonatomic, strong) UITextField *phoneNumberTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 300, 100)];
    [self.view addSubview:view];
    
    self.phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    _phoneNumberTextField.placeholder = @"手机号";
    [view addSubview:_phoneNumberTextField];
    
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, 300, 50)];
    _passwordTextField.placeholder = @"密码";
    [view addSubview:_passwordTextField];
    
    UIButton *loginButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButon setTitle:@"登录" forState:UIControlStateNormal];
    [loginButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginButon.frame = CGRectMake(100,150, 300, 100);
    [self.view addSubview:loginButon];
    [loginButon handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self loginAction];
        
    }];
    // Do any additional setup after loading the view.
}
- (void)loginAction {

    NSString *passwordString = [_passwordTextField.text ea_stringByMD5Bit32];
    NSString *phoneNumberString = _phoneNumberTextField.text;
    NSString *contryString = @"86";
    NSDictionary *dic = @{@"country_code":contryString,
                          @"phone":phoneNumberString,
                          @"password":passwordString};
    NSURL *url = [NSURL URLWithString:@"http://app.ry.api.renyan.cn/rest/login/phone"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60.f;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    request.HTTPBody = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonString);
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{
            if (!error) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                model *mo = [[model alloc] initWithDic:result];
                NSLog(@"result : %@",mo.msg);
            }
        });
    }];
    [dataTask resume];
    
    
    
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
