//
//  CardViewController.m
//  Talking
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "CardViewController.h"


static const NSUInteger kMaxTextViewNumbers = 280;

@interface CardViewController ()
<
UITextViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self creatHeadView];
    
    UIButton *addCameraImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [addCameraImage setImage:[UIImage imageNamed:@"addCamera"] forState:UIControlStateNormal];
    addCameraImage.frame = CGRectMake(self.view.width * 0.3, self.view.width * 0.3, self.view.width * 0.11, self.view .width * 0.09);
    [self.view addSubview:addCameraImage];

    
    
    
    
    UIButton *addPhotoImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [addPhotoImage setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
    addPhotoImage.frame = CGRectMake(self.view.width * 0.58, addCameraImage.y, addCameraImage.width, addCameraImage.height);
    [self.view addSubview:addPhotoImage];
    
    [addPhotoImage handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        pickerController.allowsEditing = YES;
        pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;//图片分组列表样式
        pickerController.delegate = self;
        [self.navigationController presentViewController:pickerController animated:YES completion:nil];
    }];
    
    [self setupTextView];
    
    [self creatFootView];
    
    // Do any additional setup after loading the view.
}




-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

//选择照片完成之后的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
   
    NSLog(@"%@",info);
    //刚才已经看了info中的键值对，可以从info中取出一个UIImage对象，将取出的对象赋给按钮的image
    
    UIButton *button = (UIButton *)[self.view viewWithTag:1004];
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [button setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    //如果按钮创建时用的是系统风格UIButtonTypeSystem，需要在设置图片一栏设置渲染模式为"使用原图"
    //裁成边角
    button.layer.cornerRadius = 100;
    button.layer.masksToBounds = YES;
    
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)setupTextView {
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.width * 0.17, self.view.height * 0.286, self.view.width * 0.66, self.view.height * 0.4)];
    textView.delegate  =self;
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
    
    
    self.numberLabel = [[UILabel alloc] init];
    _numberLabel.text = @"0 / 280";
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.frame = CGRectMake(self.view.width * 0.64, textView.y + textView.height, self.view.width * 0.18, self.view.width * 0.05);
    [self.view addSubview:_numberLabel];
    
    
        // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请输入内容";
    textView.font = placeHolderLabel.font;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
}

-(void)textViewDidChange:(UITextView *)textView {
    
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
    
    // 选中范围的标记
    UITextRange *textSelectedRange = [textView markedTextRange];
    // 获取高亮部分
    UITextPosition *textPosition = [textView positionFromPosition:textSelectedRange.start offset:0];
    // 如果在变化中是高亮部分在变, 就不要计算字符了
    if (textSelectedRange && textPosition) {
        return;
    }
    // 文本内容
    NSString *textContentStr = textView.text;

    NSInteger existTextNumber = textContentStr.length;
    
    if (existTextNumber > kMaxTextViewNumbers) {
        // 截取到最大位置的字符(由于超出截取部分在should时被处理了,所以在这里为了提高效率不在判断)
        NSString *str = [textContentStr substringToIndex:kMaxTextViewNumbers];
        [textView setText:str];
    }
    // 不让现实负数
    _numberLabel.text = [NSString stringWithFormat:@"%ld/%ld",MIN(kMaxTextViewNumbers,existTextNumber),kMaxTextViewNumbers];
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

- (void)creatFootView {
    UILabel *cutLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height * 0.925, self.view.width, 1)];
    cutLineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:cutLineLabel];

    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width * 0.04, self.view.height * 0.95, self.view.width * 0.2, self.view.width * 0.05)];
    textLabel.text = @"添加定位";
    textLabel.textColor = [UIColor lightGrayColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textLabel];
    
    
    
    UISwitch *swichControl = [[UISwitch alloc] initWithFrame:CGRectMake(textLabel.x + textLabel.width , textLabel.y , 0, 0)];
    swichControl.onTintColor = [UIColor yellowColor];
    [self.view addSubview:swichControl];
    [swichControl addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)switchValueChanged: (UISwitch *)switchControl {
    NSLog(@"%d",switchControl.isOn);
    
}



@end
