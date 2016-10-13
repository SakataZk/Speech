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
#import "TalkingHomeViewController.h"
#import "registerViewController.h"
#import "forgetPasswordViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UITextField *phoneNumberTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIView *textview;

@property (nonatomic, strong) UIButton *loginButon;

@property (nonatomic, strong) UIButton *forgetPasswordButton;
@end

@implementation LoginViewController




#pragma mark - 键盘高度

-(void)viewWillAppear:(BOOL)animated
{
    _passwordTextField.text = @"";
    _phoneNumberTextField.text = @"";
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat deltaY=keyBoardRect.size.height;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        _textview.transform = CGAffineTransformMakeTranslation(0, -deltaY);
        _forgetPasswordButton.transform = CGAffineTransformMakeTranslation(0, -deltaY);
        _loginButon.transform = CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}

-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        _textview.transform = CGAffineTransformIdentity;
        _forgetPasswordButton.transform = CGAffineTransformIdentity;
        _loginButon.transform = CGAffineTransformIdentity;
    }];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:SCREEN_RECT];
    backgroundImageView.image = [UIImage imageNamed:@"backgroundImage"];
    backgroundImageView.userInteractionEnabled = YES;
    [self.view addSubview:backgroundImageView];
    

    self.textview = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.55, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.12)];
    _textview.backgroundColor = [UIColor lightGrayColor];
    _textview.layer.cornerRadius = 5;
    _textview.clipsToBounds = YES;
    [backgroundImageView addSubview:_textview];
    
    self.phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, _textview.width, (_textview.height - 1) / 2)];
    _phoneNumberTextField.placeholder = @"  手机号";
    _phoneNumberTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    _phoneNumberTextField.textColor = [UIColor lightGrayColor];
    _phoneNumberTextField.backgroundColor = [UIColor whiteColor];
    [_textview addSubview:_phoneNumberTextField];

    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, _phoneNumberTextField.y + _phoneNumberTextField.height + 1, _phoneNumberTextField.width  , _phoneNumberTextField.height)];
    _passwordTextField.placeholder = @" 密码";
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.textColor = [UIColor lightGrayColor];
    _passwordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    [_textview addSubview:_passwordTextField];
    
    
    self.loginButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButon setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButon setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7] forState:UIControlStateNormal];
    _loginButon.frame = CGRectMake(_textview.x,_textview.y + _textview.height / 2 * 3, _textview.width, _textview.height / 2);
    _loginButon.backgroundColor = [UIColor colorWithRed:1.0 green:0.9015 blue:0.0745 alpha:1.0];
    [backgroundImageView addSubview:_loginButon];
    [_loginButon handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self loginAction];
    }];
    
    self.forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    _forgetPasswordButton.frame = CGRectMake(SCREEN_WIDTH * 0.7, _textview.y + _textview.height / 6 * 7, SCREEN_WIDTH * 0.2, _textview.height / 6);
    _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [backgroundImageView addSubview:_forgetPasswordButton];
    [_forgetPasswordButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        forgetPasswordViewController *forgetPasswordView = [[forgetPasswordViewController alloc] init];
        [self.navigationController pushViewController:forgetPasswordView animated:YES];
    }];
    
    
    
    UIButton *xinlangButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [xinlangButton setImage:[UIImage imageNamed:@"xinlang"] forState:UIControlStateNormal];
    xinlangButton.frame = CGRectMake(SCREEN_WIDTH * 0.2, SCREEN_HEIGHT * 0.85, SCREEN_WIDTH * 0.07, SCREEN_WIDTH * 0.07);
    [backgroundImageView addSubview:xinlangButton];
    
    UIButton *weixinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weixinButton setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    weixinButton.frame = CGRectMake(0, xinlangButton.y, xinlangButton.width, xinlangButton.height);
    weixinButton.centerX = self.view.centerX;
    [backgroundImageView addSubview:weixinButton];
    
    UIButton *QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQButton setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    QQButton.frame = CGRectMake(SCREEN_WIDTH - xinlangButton.x - xinlangButton.width, xinlangButton.y, xinlangButton.width, xinlangButton.height);
    [backgroundImageView addSubview:QQButton];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"手机注册" forState:UIControlStateNormal];
    registerButton.frame = CGRectMake(0, SCREEN_HEIGHT * 0.95, SCREEN_WIDTH * 0.4, SCREEN_HEIGHT * 0.02);
    registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    registerButton.centerX = backgroundImageView.centerX;
    [backgroundImageView addSubview:registerButton];
    [registerButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        registerViewController *registerView = [[registerViewController alloc] init];
        
        [self.navigationController pushViewController:registerView animated:YES];
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
                if ([mo.msg isEqualToString:@"登录成功"]) {
                    /**
                     *  请求头
                     */
                    NSString *token = [result objectForKey:@"token"];
                    NSDictionary *dic = [result objectForKey:@"user"];
                    NSDictionary *userDic = [dic objectForKey:@"userProfile"];
                    /**
                     *  用户Id
                     */
                    NSNumber *uid = [userDic objectForKey:@"uid"];
                    /**
                     *  用户头像
                     */
                    NSString *picture = [userDic objectForKey:@"smallPicture"];
                    TalkingHomeViewController *viewController = [[TalkingHomeViewController alloc] init];
                    viewController.token = token;
                    viewController.uid = uid;
                    viewController.picture = picture;
                    [self.navigationController pushViewController:viewController animated:NO];
                }
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



@end
