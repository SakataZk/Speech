//
//  forgetPasswordViewController.m
//  Talking
//
//  Created by dllo on 16/10/11.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "forgetPasswordViewController.h"
#import "NSString+EAMD5.h"
#import "TalkingHomeViewController.h"
@interface forgetPasswordViewController ()


@property (nonatomic, strong) UIView *textFieldView;

@property (nonatomic, strong) UITextField *phoneNumber;

@property (nonatomic, strong) UITextField *codeNumber;

@property (nonatomic, strong) UITextField *passWordNubmer;
@end

@implementation forgetPasswordViewController
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat deltaY=keyBoardRect.size.height;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        _textFieldView.transform = CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}

-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        _textFieldView.transform = CGAffineTransformIdentity;
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:SCREEN_RECT];
    backgroundImageView.image = [UIImage imageNamed:@"backgroundImage"];
    backgroundImageView.userInteractionEnabled = YES;
    [self.view addSubview:backgroundImageView];
    
    self.textFieldView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.45, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3)];
    [self.view addSubview:_textFieldView];
    
    UIView *textview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _textFieldView.width, SCREEN_HEIGHT * 0.18)];
    textview.layer.cornerRadius = 5;
    textview.clipsToBounds = YES;
    textview.backgroundColor = [UIColor lightGrayColor];
    [_textFieldView addSubview:textview];
    
    self.phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, textview.width, (textview.height - 2) / 3)];
    _phoneNumber.placeholder = @"    手机号";
    _phoneNumber.keyboardType = UIKeyboardTypeNamePhonePad;
    _phoneNumber.textColor = [UIColor lightGrayColor];
    _phoneNumber.backgroundColor = [UIColor whiteColor];
    _phoneNumber.font = [UIFont systemFontOfSize:15];
    [textview addSubview:_phoneNumber];
    
    self.codeNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, _phoneNumber.y + _phoneNumber.height + 1, _phoneNumber.width, _phoneNumber.height)];
    _codeNumber.placeholder = @"    验证码";
    _codeNumber.keyboardType = UIKeyboardTypeNamePhonePad;
    _codeNumber.textColor = [UIColor lightGrayColor];
    _codeNumber.backgroundColor = [UIColor whiteColor];
    _codeNumber.font = [UIFont systemFontOfSize:15];
    [textview addSubview:_codeNumber];
    
    UIButton *getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [getCodeButton setTitle:@"获取验证码" forState: UIControlStateNormal];
    getCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [getCodeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    getCodeButton.frame = CGRectMake(_codeNumber.width / 3 * 2, _codeNumber.y, _codeNumber.width / 3, _codeNumber.height);
    [textview addSubview:getCodeButton];
    [getCodeButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (_phoneNumber.text.length == 11) {
            [self getCode];
        }
    }];
    
    self.passWordNubmer = [[UITextField alloc] initWithFrame:CGRectMake(_codeNumber.x, _codeNumber.y + _codeNumber.height + 1, _codeNumber.width, _codeNumber.height)];
    _passWordNubmer.placeholder = @"    密码";
    _passWordNubmer.keyboardType = UIKeyboardTypeNamePhonePad;
    _passWordNubmer.textColor = [UIColor lightGrayColor];
    _passWordNubmer.backgroundColor = [UIColor whiteColor];
    _passWordNubmer.font = [UIFont systemFontOfSize:15];
    [textview addSubview:_passWordNubmer];
    
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"完成" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7] forState:UIControlStateNormal];
    registerButton.frame = CGRectMake(0, SCREEN_HEIGHT * 0.21, _passWordNubmer.width, _passWordNubmer.height);
    registerButton.layer.cornerRadius = 5;
    registerButton.clipsToBounds = YES;
    registerButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.9015 blue:0.0745 alpha:1.0];
    [_textFieldView addSubview:registerButton];
    [registerButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self test];
    }];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    returnButton.frame = CGRectMake(0, SCREEN_HEIGHT * 0.95, SCREEN_WIDTH * 0.4, SCREEN_HEIGHT * 0.02);
    returnButton.titleLabel.font = [UIFont systemFontOfSize:15];
    returnButton.centerX = backgroundImageView.centerX;
    [backgroundImageView addSubview:returnButton];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    // Do any additional setup after loading the view.
}

- (void)getCode {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/account/forgetpw?phone=%@&country_code=86",_phoneNumber.text];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject objectForKey:@"msg"]);
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error : %@",error);
         }];
}

- (void)test {
    NSString *passwordString = [_passWordNubmer.text ea_stringByMD5Bit32];
    NSString *phoneNumberString = _phoneNumber.text;
    NSString *contryString = @"86";
    NSDictionary *dic = @{@"country_code":contryString,
                          @"phone":phoneNumberString,
                          @"code":_codeNumber.text,
                          @"new_password":passwordString};
    NSURL *url = [NSURL URLWithString:@"http://app.ry.api.renyan.cn/rest/account/resetpwbyphone"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"107" forHTTPHeaderField:@"Content-Length"];
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
                NSLog(@"%@",[result objectForKey:@"msg"]);
                if ([[result objectForKey:@"msg"] isEqualToString:@"密码重置成功"]) {
                    [self loginAction];
                }
            }
        });
    }];
    [dataTask resume];
}

- (void)loginAction {
    
    NSString *passwordString = [_passWordNubmer.text ea_stringByMD5Bit32];
    NSString *phoneNumberString = _phoneNumber.text;
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
                if ([[result objectForKey:@"msg"] isEqualToString:@"登录成功"]) {
                    NSString *token = [result objectForKey:@"token"];
                    NSDictionary *dic = [result objectForKey:@"user"];
                    NSDictionary *userDic = [dic objectForKey:@"userProfile"];
                    NSNumber *uid = [userDic objectForKey:@"uid"];
                    NSString *picture = [userDic objectForKey:@"smallPicture"];
                    TalkingHomeViewController *viewController = [[TalkingHomeViewController alloc] init];
                    viewController.token = token;
                    viewController.uid = uid;
                    viewController.picture = picture;
                    [self.navigationController pushViewController:viewController animated:NO];
                }
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
